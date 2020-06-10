


import 'package:corona_tracker/base_config/base_config.dart';

class ScanqrFailedEvent extends BaseEvent {
  String err;
  ScanqrFailedEvent(this.err);
}