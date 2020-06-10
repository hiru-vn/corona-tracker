import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // ************************************************************************************
  // *                                                                                  *
// *   the code follow https://pub.dev/packages/flutter_local_notifications example   *
  // *                                                                                  *
  // ************************************************************************************

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationService(this._flutterLocalNotificationsPlugin);

  //show noti immediately
  showNotification(int id, String title, String description) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(
        id, title, description, platformChannelSpecifics,
        payload: 'item x');
  }

  // set time to show noti
  showSchedule(DateTime dateTime, int id, String title, String description) {
    final vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show schedule channel id',
        'show schedule channel name',
        'show schedule description',
        //vibrationPattern: vibrationPattern,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    _flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      description,
      dateTime,
      platformChannelSpecifics,
    );
  }

  showWeeklyAtDayAndTime(
      Time time, Day day, int id, String title, String description) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show weekly channel id',
      'show weekly channel name',
      'show weekly description',
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      id,
      title,
      description,
      day,
      time,
      platformChannelSpecifics,
    );
  }

  showDailyAtTime(Time time, int id, String title, String description) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show daily channel id',
      'show daily channel name',
      'show daily description',
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    _flutterLocalNotificationsPlugin.showDailyAtTime(
      id,
      title,
      description,
      time,
      platformChannelSpecifics,
    );
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() {
    final pendingNotifications =
        _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  cancelNotification(int id) {
    _flutterLocalNotificationsPlugin.cancel(id);
  }

  cancelAllNotifications() {
    _flutterLocalNotificationsPlugin.cancelAll();
  }

  scheduleAllNotifications(List<NotificationJson> notifications) {
    for (final notification in notifications) {
      showDailyAtTime(
        Time(notification.hour, notification.minute),
        notification.notificationId,
        notification.title,
        notification.description,
      );
    }
  }
}

class NotificationJson {
  int notificationId;
  String title;
  String description;
  int hour;
  int minute;

  NotificationJson(this.title, this.description, this.hour, this.minute);

  NotificationJson.fromJson(Map<String, dynamic> json) {
    notificationId = json['id'];
    title = json['title'];
    description = json['description'];
    hour = json['hour'];
    minute = json['minute'];
  }
}
