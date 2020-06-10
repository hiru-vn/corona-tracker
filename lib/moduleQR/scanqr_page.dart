import 'package:corona_tracker/services/navigate_services.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:corona_tracker/base_config/base_config.dart';
import 'package:corona_tracker/base_widget/base_widget.dart';

import 'data/scanqr_repo.dart';
import 'data/scanqr_srv.dart';
import 'events/scanqrFail_event.dart';
import 'events/scanqrSuccess_event.dart';
import 'scanqr_bloc.dart';
import 'widgets/qrcode_widget.dart';

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
                // TODO: fetch API tại đây
                String qrcode = event.data;
                // TODO: fetch API tại đây
                Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return LoadingTask(
      bloc: scanqrBloc,
      child: QrcodeWidget(scanqrBloc, controller, handleEvent),
    );
  }
}
