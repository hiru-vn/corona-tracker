import 'package:corona_tracker/ui/custom_color.dart';
import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:corona_tracker/ui/reuseable/spacing_box.dart';
import 'package:corona_tracker/ui/widgets/login/btn_login.dart';
import 'package:corona_tracker/ui/widgets/login/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginPhoneOtp extends StatefulWidget {
  final PageController pageController;

  const LoginPhoneOtp(this.pageController);
  @override
  _LoginPhoneOtpState createState() => _LoginPhoneOtpState();
}

class _LoginPhoneOtpState extends State<LoginPhoneOtp>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodeOtp = FocusNode();
  final PageController _pageController = PageController();

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 50.0, end: 200.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _focusNodePhone.addListener(() {
      if (_focusNodePhone.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    _focusNodeOtp.addListener(() {
      if (_focusNodeOtp.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    super.initState();
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
        SizedBox(height: _animation.value),
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
                      focusNode: focusNode,
                    ),
                    const SpacingBox(
                      height: 1,
                    ),
                    BtnLogin(
                      text: 'Gửi mã OTP',
                      formLoginKey: _formPhoneOtpKey,
                      onPress: () {},
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
    return Center(
      child: Form(
        key: _formOtpKey,
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
                  _buildPinField(),
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
          'Lưu ý: mã sẽ tự động hết hạn sau 60 giây',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: ResponsiveSize.textMultiplier * 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        // StreamProvider<bool>.value(
        //   initialData: true,
        //   value: bloc.countdownStartStream,
        //   child: Consumer<bool>(
        //     builder: (context, enable, child) => enable
        //         ? Countdown(
        //             duration: const Duration(seconds: 60),
        //             onFinish: () {
        //               bloc.countdownStartSink.add(false);
        //             },
        //             builder: (ctx, remaining) {
        //               return Text(
        //                 '${remaining.inSeconds}',
        //                 style: TextStyle(
        //                   color: CustomColor.secondary,
        //                   fontSize: ResponsiveSize.textMultiplier * 2,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               );
        //             },
        //           )
        //         : Text(
        //             '0',
        //             style: TextStyle(
        //               color: CustomColor.secondary,
        //               fontSize: ResponsiveSize.textMultiplier * 2,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //   ),
        // ),
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

  Widget _buildPinField() {
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
        animationDuration: Duration(milliseconds: 300),
        borderRadius: BorderRadius.circular(5),
        fieldHeight: ResponsiveSize.widthMultiplier * 12,
        fieldWidth: ResponsiveSize.widthMultiplier * 10,
        onChanged: (pin) {},
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
