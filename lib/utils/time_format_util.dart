import 'package:flutter/material.dart';

class TimeFormater {
  static String shortTimeFormatWithoutSecond(TimeOfDay timeOfDay) =>
      timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString();
}
