import 'package:corona_tracker/base_config/base_config.dart';
import 'package:corona_tracker/globals.dart';
import 'package:dio/dio.dart';

import 'data/scanqr_repo.dart';
import 'events/qrdetected_event.dart';
import 'events/scanqrFail_event.dart';
import 'events/scanqrSuccess_event.dart';

class ScanqrBloc extends BaseBloc with ChangeNotifier {
  ScanqrBloc({@required ScanqrRepo scanqrRepo}) {
    _scanqrRepo = scanqrRepo;
  }

  ScanqrRepo _scanqrRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case QrdetectedEvent:
        handleQrdetectedEvent(event);
        break;
      default:
    }
    notifyListeners();
  }

  handleQrdetectedEvent(event) async {
    QrdetectedEvent e = event as QrdetectedEvent;
    try {
      var dio = Dio();
      Response response;
      const baseURL = baseLocalHost + "userstore/create";
      int uid = await SPref.instance.get('userId');
      var data = {
        "timein": "20:22 23/2/1999",
        "timout": "20:22 23/2/1999",
        "userid": 3,
        "storeid": int.parse(e.code),
      };
      response = await dio.post(baseURL, data: data);

      processEventSink.add(ScanqrSucessEvent(e.code));
    } catch (e) {
      processEventSink.add(ScanqrFailedEvent(e.message.toString()));
      print(e);
    } finally {
      loadingSink.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
