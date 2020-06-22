import 'package:audioplayers/audio_cache.dart';
import 'package:corona_tracker/moduleQR/events/qrdetected_event.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:corona_tracker/base_config/base_config.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

import '../scanqr_bloc.dart';
import 'header_qr.dart';

class QrcodeWidget extends StatefulWidget {
  final ScanqrBloc bloc;
  final QRViewController controller;
  final Function handleEvent;

  QrcodeWidget(this.bloc,this.controller, this.handleEvent);

  @override
  _QrcodeWidgetState createState() => _QrcodeWidgetState();
}

class _QrcodeWidgetState extends State<QrcodeWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final AudioCache audioCache = AudioCache();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  _onQrViewCreated(QRViewController controller) async {
    //controller = widget.controller;
    controller.scannedDataStream.listen((scanData) {
      print('scan data ${scanData.toString()}');
      controller.pauseCamera();
      _playCheckSound();
      widget.bloc.event
          .add(QrdetectedEvent(scanData)); // return a qr value in text
    });
  }


  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanqrBloc>(
      listener: widget.handleEvent,
          child: Stack(
        key: _scaffoldKey,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) => _onQrViewCreated(controller),
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 0,
                cutOutSize: 300,
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 6,
            child: Container(
              width: SizeConfig.widthMultiplier * 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: SizeConfig.heightMultiplier * 15),
                  Text(
                    CustomString.requestQrCodeScanningVn,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textMultiplier * 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Headerqr(),
          ),
        ],
      ),
    );
  }

  _playCheckSound() async {
    await audioCache.play("assets/images/beep.mp3");
  }
}
