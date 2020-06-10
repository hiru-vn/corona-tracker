
import 'dart:async';

import 'package:corona_tracker/base_config/base_config.dart';


class AppBloc extends BaseBloc {
  final appController$ = StreamController<BaseEvent>.broadcast();
  Stream get appStream => appController$.stream;
  Sink get appSink => appController$.sink;

  @override
  void dispatchEvent(BaseEvent event) {}

  

  @override
  void dispose() {
    appController$.close();
    super.dispose();
  }
}