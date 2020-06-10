import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local_notification/local_notification.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService _instance = FirebaseService._();

  static FirebaseService get instance => _instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _random = Random();

  NotificationService _notificationService;

  void init() {
    print('init FirebaseService');
    // Prevent running multiple isolate/thread in Flutter
    if (_notificationService != null) return;

    _firebaseMessaging
      ..configure(
        onMessage: _onMessage,
        onBackgroundMessage: onBackgroundMessage,
        onLaunch: _onLaunch,
        onResume: _onResume,
      )
      ..requestNotificationPermissions();

    _notificationService = NotificationService(FlutterLocalNotificationsPlugin()
      ..initialize(InitializationSettings(
        AndroidInitializationSettings(
            'ic_launcher'), // file name in android/app/src/main/res/drawable/,
        IOSInitializationSettings(),
      )));
  }

  int _generateRandomId() {
    return -pow(2, 31) + _random.nextInt(pow(2, 31) * 2);
  }

  Future<void> _onMessage(Map<String, dynamic> message) async {
    String title = '';
    String body = '';
    print("onMessage: $message");

    try {
      // Sometimes iOS's push notification message send 2 formats.
      // iOS & Android
      title = message["notification"]["title"].toString();
      body = message["notification"]["body"].toString();
    } catch (Exception) {
      // If in above iOS case failed
      // It will hit this exception always be iOS becaust it has 2 formats.
      title = message["aps"]["alert"]["title"].toString();
      body = message["aps"]["alert"]["body"].toString();
    }

    _notificationService.showNotification(_generateRandomId(), title, body);
  }

  Future<void> _onResume(Map<String, dynamic> message) async {
    print("onResume: $message");
  }

  Future<void> _onLaunch(Map<String, dynamic> message) async {
    print("onLaunch: $message");

    // in case need to navigate to specific page when click on notification when app terminated
    // save flag variable to check
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasNewMess', true);
  }

  static Future<void> onBackgroundMessage(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      // final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      print("notification here");
    }

    // Or do other work.
    return Future.delayed(const Duration(milliseconds: 500), () => 0 == 0);
  }

  static Future<void> saveUnreadMessageStackToPrefs(
      String title, String body) async {
    // save message to show later when open app
    // use this along with getMessageStackAndShow to show message when open app
    // usually use in onMessage function

    final prefs = await SharedPreferences.getInstance();
    var firebaseMessages = prefs.getStringList("firebaseMessages");
    firebaseMessages ??= firebaseMessages = <String>[];
    firebaseMessages.addAll(<String>[
      title,
      body,
    ]);
    await prefs.setStringList('firebaseMessages', firebaseMessages);
    await prefs.setInt('unreadMessages', firebaseMessages.length);
  }

  Future<void> getMessageStackAndShow() {
    // save message to show later when open app
    // this function can be call when user sign in, to show notify list that saved in preferences
    // use this along with saveUnreadMessageStackToPrefs to save firebase message in preferences

    return SharedPreferences.getInstance().then((prefs) {
      final firebaseMessages = prefs.getStringList("firebaseMessages");
      if (firebaseMessages != null) {
        for (var i = 0; i < firebaseMessages.length; i += 2) {
          if (i > 1 &&
              firebaseMessages[i] != firebaseMessages[i - 2] &&
              firebaseMessages[i + 1] != firebaseMessages[i - 1]) {
            // check if 2 message is the same
            _notificationService.showNotification(
                i, firebaseMessages[i], firebaseMessages[i + 1]);
          }
        }
        prefs.remove('firebaseMessages');
      }
    });
  }

  Future<String> getDeviceToken() {
    //return _firebaseMessaginggetToken();
  }

  //
  // configure for auth
  //
}
