import 'package:corona_tracker/providers/login/login_logic.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  LoginController() {
    debugPrint('init LoginController');
    logic = LoginLogic(this);
  }

  LoginLogic logic;
  String phone;
  String otp;
  String actualCode;

  void refresh() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("remove login model");
  }
}
