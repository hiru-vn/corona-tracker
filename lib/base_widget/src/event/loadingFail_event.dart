
// this event do nothing, do not implements dispatch on this event



import 'package:corona_tracker/base_config/base_config.dart';

class LoadingFailEvent extends BaseEvent {
  String err;
  LoadingFailEvent(this.err);
}