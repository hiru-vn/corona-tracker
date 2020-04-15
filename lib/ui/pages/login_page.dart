import 'package:corona_tracker/ui/reuseable/base_page.dart';
import 'package:corona_tracker/ui/widgets/login/login_phone_otp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final PageController pageController = PageController(keepPage: false);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          LoginPhoneOtp(pageController),
        ],
      ),
    );
  }
}
