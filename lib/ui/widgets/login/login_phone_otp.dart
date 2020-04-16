import 'package:corona_tracker/providers/login/login_controller.dart';
import 'package:corona_tracker/services/navigate_services.dart';
import 'package:corona_tracker/ui/custom_color.dart';
import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:corona_tracker/ui/reuseable/spacing_box.dart';
import 'package:corona_tracker/ui/widgets/login/btn_login.dart';
import 'package:corona_tracker/ui/widgets/login/phone_field.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class LoginPhoneOtp extends StatefulWidget {
  final PageController pageController;

  const LoginPhoneOtp(this.pageController);
  @override
  _LoginPhoneOtpState createState() => _LoginPhoneOtpState();
}

class _LoginPhoneOtpState extends State<LoginPhoneOtp> {
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodeOtp = FocusNode();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodePhone.dispose();
    _focusNodeOtp.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              PhoneOtpView(
                _pageController,
                focusNode: _focusNodePhone,
              ),
              OtpConfirmView(
                _pageController,
                focusNode: _focusNodePhone,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PhoneOtpView extends StatelessWidget {
  final GlobalKey<FormState> _formPhoneOtpKey = GlobalKey<FormState>();
  final FocusNode focusNode;
  final PageController pageController;

  PhoneOtpView(this.pageController, {this.focusNode});
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return Container(
      width: ResponsiveSize.widthMultiplier * 100,
      padding: EdgeInsets.only(top: ResponsiveSize.heightMultiplier * 30),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: ResponsiveSize.widthMultiplier * 10,
            right: ResponsiveSize.widthMultiplier * 10,
          ),
          child: Form(
            key: _formPhoneOtpKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Xác thực OTP',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.green,
                    fontSize: ResponsiveSize.textMultiplier * 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Sử dụng số điện thoại đăng kí tài khoản của bạn',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.green,
                        fontSize: ResponsiveSize.textMultiplier * 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SpacingBox(
                      height: 2,
                    ),
                    PhoneField(
                      //focusNode: focusNode,
                      onSave: (phone) => controller.phone = phone,
                    ),
                    const SpacingBox(
                      height: 1,
                    ),
                    BtnLogin(
                      text: 'Gửi mã OTP',
                      formLoginKey: _formPhoneOtpKey,
                      onPress: () {
                        final formState = _formPhoneOtpKey.currentState;
                        if (!formState.validate()) {
                          return;
                        }
                        formState.save();
                        controller.logic.requestOtp();
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.decelerate);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpConfirmView extends StatelessWidget {
  final GlobalKey<FormState> _formOtpKey = GlobalKey<FormState>();
  final FocusNode focusNode;
  final PageController pageController;

  OtpConfirmView(this.pageController, {this.focusNode});
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return Center(
      child: Form(
        key: _formOtpKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Xác thực OTP',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.green,
                fontSize: ResponsiveSize.textMultiplier * 3,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ResponsiveSize.widthMultiplier * 10,
                right: ResponsiveSize.widthMultiplier * 10,
              ),
              child: Column(
                children: <Widget>[
                  _createlabel(),
                  const SpacingBox(
                    height: 1,
                  ),
                  _createSublabel(),
                  const SpacingBox(
                    height: 1,
                  ),
                  _buildPinField(
                      onChanged: controller.logic.signInWithPhoneNumber),
                  SizedBox(height: ResponsiveSize.heightMultiplier * 2),
                  _buildResend(),
                ],
              ),
            ),
            _buildBackBtn(),
          ],
        ),
      ),
    );
  }

  Widget _createlabel() {
    return Text(
      'Nhập mã otp được gửi đến số điện thoại của bạn',
      style: TextStyle(
        decoration: TextDecoration.none,
        color: Colors.green,
        fontSize: ResponsiveSize.heightMultiplier * 2,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _createSublabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Lưu ý: mã sẽ tự động hết hạn sau ',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ResponsiveSize.textMultiplier * 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        Countdown(
          duration: const Duration(seconds: 60),
          onFinish: () {},
          builder: (ctx, remaining) {
            return Text(
              '${remaining.inSeconds}',
              style: TextStyle(
                color: CustomColor.secondary,
                fontSize: ResponsiveSize.textMultiplier * 2,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
        Text(
          ' giây',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ResponsiveSize.textMultiplier * 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPinField({Function onChanged}) {
    return Container(
      width: ResponsiveSize.widthMultiplier * 80,
      child: PinCodeTextField(
        length: 6,
        obsecureText: false,
        backgroundColor: Colors.transparent,
        textInputType: TextInputType.number,
        animationType: AnimationType.fade,
        inactiveColor: CustomColor.primary,
        selectedColor: CustomColor.secondary,
        shape: PinCodeFieldShape.box,
        animationDuration: const Duration(milliseconds: 300),
        borderRadius: BorderRadius.circular(5),
        fieldHeight: ResponsiveSize.widthMultiplier * 12,
        fieldWidth: ResponsiveSize.widthMultiplier * 10,
        onChanged: (pin) {
          if (pin.length == 6) {
            onChanged(pin);
            navigatorKey.currentState.pushReplacementNamed(Views.homePage);
          }
        },
      ),
    );
  }

  Widget _buildBackBtn() {
    return Padding(
      padding: EdgeInsets.all(ResponsiveSize.widthMultiplier * 4),
      child: InkWell(
        onTap: () => pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.keyboard_arrow_left),
            const Text('Quay lại'),
          ],
        ),
      ),
    );
  }

  Widget _buildResend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Không nhận được mã OTP?',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ResponsiveSize.textMultiplier * 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            ' Gửi lại',
            style: TextStyle(
              color: CustomColor.secondary,
              decoration: TextDecoration.none,
              fontSize: ResponsiveSize.heightMultiplier * 2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
