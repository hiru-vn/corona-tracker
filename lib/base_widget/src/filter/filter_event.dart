import 'package:corona_tracker/base_config/base_config.dart';

class FilterEvent extends BaseEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  FilterEvent({this.status, this.startDate, this.endDate});
}
