import 'package:audioplayers/audio_cache.dart';
import 'package:corona_tracker/moduleQR/events/qrdetected_event.dart';
import 'package:corona_tracker/moduleQR/widgets/header_qr.dart';
import 'package:corona_tracker/services/navigate_services.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:corona_tracker/base_config/base_config.dart';
import 'package:corona_tracker/base_widget/base_widget.dart';

import 'data/scanqr_repo.dart';
import 'data/scanqr_srv.dart';
import 'events/scanqrFail_event.dart';
import 'events/scanqrSuccess_event.dart';
import 'scanqr_bloc.dart';

class Scanqrpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePageContainer(
      title: CustomString.qrScanningVn,
      di: [
        Provider.value(value: ScanqrSrv()),
        ProxyProvider<ScanqrSrv, ScanqrRepo>(
          update: (context, scanqrSrv, previous) =>
              ScanqrRepo(scanqrSrv: scanqrSrv),
        ),
      ],
      bloc: [],
      child: ScanqrProvider(),
    );
  }
}

class ScanqrProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ScanqrBloc(scanqrRepo: Provider.of(context)),
        child: ScanqrBody());
  }
}

class ScanqrBody extends StatefulWidget {
  @override
  _ScanqrBodyState createState() => _ScanqrBodyState();
}

class _ScanqrBodyState extends State<ScanqrBody> with BlocCreator {
  ScanqrBloc scanqrBloc;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final AudioCache audioCache = AudioCache();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (scanqrBloc == null) {
      scanqrBloc = createBloc<ScanqrBloc>();
    }
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  handleEvent(BaseEvent event) {
    if (event is ScanqrFailedEvent) {
      Alert(
        context: context,
        title: "Quét không thành công",
        desc: event.err,
        buttons: [
          DialogButton(
            child: Text(
              "Quét lại ",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Future.delayed(Duration(microseconds: 300), () {
                Navigator.pop(context);
                controller?.resumeCamera();
                setState(() {});
              });
            },
            color: Colors.redAccent,
          ),
        ],
      ).show();
      return;
    }
    if (event is ScanqrSucessEvent) {
      Alert(
        context: context,
        title: "Quét thành công",
        desc: event.data,
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Future.delayed(const Duration(microseconds: 300), () {
                String idstore = event.data;
                // nav to detail
                Navigator.pop(context);
              });
            },
            color: Colors.redAccent,
          ),
          DialogButton(
            child: Text(
              "Quét lại",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Future.delayed(Duration(microseconds: 300), () {
                navigatorKey.currentState.pop();
                controller?.resumeCamera();
              });
            },
            color: Colors.redAccent,
          ),
        ],
      ).show();
      return;
    }
  }

  _playCheckSound() async {
    await audioCache.play("assets/images/beep.mp3");
  }

  _onQrViewCreated(QRViewController controller) async {
    this.controller = controller;
    this.controller.scannedDataStream.listen((scanData) {
      print('scan data ${scanData.toString()}');
      this.controller.pauseCamera();
      _playCheckSound();
      scanqrBloc.event
          .add(QrdetectedEvent(scanData)); // return a qr value in text
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingTask(
      bloc: scanqrBloc,
      child: BlocListener<ScanqrBloc>(
        listener: handleEvent,
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
      ),
    );
  }
}
