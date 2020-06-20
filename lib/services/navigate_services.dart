import 'package:corona_tracker/moduleQR/scanqr_page.dart';
import 'package:corona_tracker/providers/home/home_controller.dart';
import 'package:corona_tracker/providers/login/login_controller.dart';
import 'package:corona_tracker/providers/qr/qr_controller.dart';
import 'package:corona_tracker/ui/pages/home_page.dart';
import 'package:corona_tracker/ui/pages/login_page.dart';
import 'package:corona_tracker/ui/pages/notification_page.dart';
import 'package:corona_tracker/ui/pages/qr_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corona_tracker/ui/pages/detailStore.dart';

// this key use as navigator
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// list route
class Views {
  static const String loginPage = 'loginPage';
  static const String homePage = 'homePage';
  static const String qrPage = 'qrPage';
  static const String notificationPage = 'notificationPage';
  static const String detailstore = 'detailstore';
}

//
// example usage: navigatorKey.currentState.pushNamed(Views.profileScreen);
//
Route<dynamic> generateRoute(RouteSettings settings) {
  // final Map args = settings.arguments; // in case passing argruments
  switch (settings.name) {
    case Views.loginPage:
      return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => LoginController(), child: LoginPage()));    
    case Views.homePage:
      return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => HomeController(), child: HomePage()));
    case Views.qrPage:
      return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => QrController(), child: Scanqrpage()));
    case Views.notificationPage:
      return CupertinoPageRoute(
          builder: (context) => NotificationPage()
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Đường dẫn đến ${settings.name} không tồn tại'),
          ),
        ),
      );
  }
}
