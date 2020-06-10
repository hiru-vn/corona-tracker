
import 'package:flutter/material.dart';
import 'package:corona_tracker/base_config/base_config.dart';

class FullWidthButton extends StatelessWidget {
  final Function onPress;
  final String text;
  final Color color;
  FullWidthButton({this.onPress, this.text, this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.widthMultiplier * 90,
      height: 45,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.transparent),
        ),
        onPressed: onPress,
        color: color?? CustomColor.main,
        textColor: Colors.white,
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 2.5,
          ),
        ),
      ),
    );
  }
}
