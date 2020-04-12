import 'dart:typed_data';
import 'package:corona_tracker/data/notification_json.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // ************************************************************************************
  // *                                                                                  *
  // *   the code follow https://pub.dev/packages/flutter_local_notifications example   *
  // *                                                                                  *
  // ************************************************************************************

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationService() {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  //show noti immediately
  Future<void> showNotification(int id, String title, String description) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        id, title, description, platformChannelSpecifics,
        payload: 'item x');
  }

  // set time to show noti
  Future<void> showSchedule(
      DateTime dateTime, int id, String title, String description) async {
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
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      description,
      dateTime,
      platformChannelSpecifics,
    );
  }

  Future<void> showWeeklyAtDayAndTime(
      Time time, Day day, int id, String title, String description) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show weekly channel id',
      'show weekly channel name',
      'show weekly description',
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      id,
      title,
      description,
      day,
      time,
      platformChannelSpecifics,
    );
  }

  Future<void> showDailyAtTime(
      Time time, int id, String title, String description) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show daily channel id',
      'show daily channel name',
      'show daily description',
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.showDailyAtTime(
      id,
      title,
      description,
      time,
      platformChannelSpecifics,
    );
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
    final pendingNotifications =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> scheduleAllNotifications(
      List<NotificationJson> notifications) async {
    for (final notification in notifications) {
      await showDailyAtTime(
        Time(notification.hour, notification.minute),
        notification.notificationId,
        notification.title,
        notification.description,
      );
    }
  }
}
