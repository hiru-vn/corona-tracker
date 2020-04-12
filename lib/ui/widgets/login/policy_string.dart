
import 'package:corona_tracker/services/strings.dart';
import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:flutter/material.dart';

class PolicyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ResponsiveSize.heightMultiplier * 2,
          horizontal: ResponsiveSize.widthMultiplier * 5),
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, '/rules-doc');
        },
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.green,
              fontSize: ResponsiveSize.textMultiplier * 1.8,
            ),
            children: <TextSpan>[
              TextSpan(
                text: Strings.agree['vi'],
              ),
              TextSpan(
                text: Strings.rule['vi'],
                style: TextStyle(
                    color: Colors.orange, decoration: TextDecoration.underline),
              ),
              TextSpan(text: Strings.appName['vi']),
            ],
          ),
        ),
      ),
    );
  }
}
