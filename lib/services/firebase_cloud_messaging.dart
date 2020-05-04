import 'dart:async';
import 'package:corona_tracker/services/local_message.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessageService {
  
  FirebaseMessageService.getInstance() {
    if (_instance == null) {
      init();
    }
    _instance ??= FirebaseMessageService._internal();
  }
  FirebaseMessageService._internal();

  static FirebaseMessageService _instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<FirebaseMessage> firebaseMessages = [];
  String token;

  void init() {
    debugPrint('init FirebaseMessageService');
    _firebaseMessaging
      ..configure(
        onMessage: onMessage,
        onBackgroundMessage: onBackgroundMessage,
        onLaunch: onLaunch,
        onResume: onResume,
      )
      ..requestNotificationPermissions();
  }

  static Future<void> onMessage(Map<String, dynamic> message) async {
    await NotificationService().showNotification(
        0,
        message["notification"]["title"].toString(),
        message["notification"]["body"].toString());

    debugPrint("onMessage: $message");
  }

  static Future<void> onLaunch(Map<String, dynamic> message) async {
    debugPrint("onLaunch: $message");
  }

  static Future<void> onResume(Map<String, dynamic> message) async {
    debugPrint("onResume: $message");
  }

  static Future<void> onBackgroundMessage(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      // final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      debugPrint("notification here");
    }

    // Or do other work.
    return Future.delayed(const Duration(milliseconds: 500), () => 0 == 0);
  }

  Future<String> getDeviceToken() {
    return _firebaseMessaging.getToken();
  }
}

class FirebaseMessage {
  final String title;
  final String body;

  const FirebaseMessage(this.title, this.body);
}
