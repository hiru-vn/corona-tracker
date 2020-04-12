import 'package:intl/intl.dart';

class DateFormater {
  static String standardDateFormat(DateTime date) =>
      DateFormat('MM/dd/yyyy h:mm a', 'vi-VN').format(date);

  static String shortDateFormat(DateTime date) =>
      DateFormat('EEE, MMM d, yyyy', 'vi-VN').format(date);

  static String vnDateFormat(DateTime date) =>
      DateFormat('dd/MM/yyyy', 'vi-VN').format(date);

  static String vnDateTimeFormat(DateTime date) =>
      DateFormat('dd/MM/yyyy h:mm a', 'vi-VN').format(date);

  static String timeFormatOnly(DateTime date) =>
      DateFormat('h:mm a', 'vi-VN').format(date);

  static String shortDateFormatWithoutDay(DateTime date) =>
      DateFormat('MMMM yyyy', 'vi-VN').format(date);

  static String shortDateFormatWithoutYear(DateTime date) =>
      DateFormat('dd/MM', 'vi-VN').format(date);

  static String shortDateFormatWithoutMonthAndDay(DateTime date) =>
      DateFormat('yyyy', 'vi-VN').format(date);

  static DateTime getDateWithoutTime(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime getDateWithoutDayAndTime(DateTime date) =>
      DateTime(date.year, date.month);

  static DateTime getDateWithoutMonthAndDayAndTime(DateTime date) =>
      DateTime(date.year);

  static String getStringWeekDay(DateTime date) =>
      (date.weekday != 7) ? "Thứ " + (date.weekday + 1).toString() : "Chủ nhật";

  static String convertToISO8601DateFormat(DateTime date) =>
      DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(date);

  static DateTime getDateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
