import 'package:corona_tracker/ui/widgets/login/login_phone_otp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final PageController pageController = PageController(keepPage: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(),
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            LoginPhoneOtp(pageController),
          ],
        ),
      ),
    );
  }
}
