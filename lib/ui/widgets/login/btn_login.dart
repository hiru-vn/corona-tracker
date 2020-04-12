
import 'package:corona_tracker/services/strings.dart';
import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:flutter/material.dart';

class BtnLogin extends StatelessWidget {
  final GlobalKey<FormState> formLoginKey;
  final Function onPress;
  final String text;
  const BtnLogin({this.formLoginKey, this.onPress, this.text});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveSize.widthMultiplier * 90,
      height: ResponsiveSize.heightMultiplier * 6,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.grey),
        ),
        onPressed: onPress,
        color: Colors.green,
        textColor: Colors.white,
        child: Text(
          text??Strings.login['vi'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ResponsiveSize.textMultiplier * 2,
          ),
        ),
      ),
    );
  }
}
