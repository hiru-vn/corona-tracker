import 'package:corona_tracker/providers/login/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginLogic {
  LoginLogic(this._model);

  final LoginController _model;

  void requestOtp() {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _model.phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  void logout() {}

  void _codeSent(String verificationId, [int forceResendingToken]) {
    _model.actualCode = verificationId;
  }

  void _codeAutoRetrievalTimeout(String verificationId) {}

  void _verificationFailed(AuthException authException) {}

  void _verificationCompleted(AuthCredential auth) {
    FirebaseAuth.instance.signInWithCredential(auth).then((authResult) {
      if (authResult.user != null) {
      } else {}
    }).catchError((error) {});
  }

  Future<void> signInWithPhoneNumber(String smsCode) async {
    final _authCredential = await PhoneAuthProvider.getCredential(
        verificationId: _model.actualCode, smsCode: smsCode);
    await FirebaseAuth.instance
        .signInWithCredential(_authCredential)
        .catchError((error) {
    }).then((user) async {
    });
  }
}
