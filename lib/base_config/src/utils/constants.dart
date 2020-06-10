import 'package:flutter/material.dart';



Color ptPrimaryColor(BuildContext context) => Theme.of(context).primaryColor;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double scaleWidth(BuildContext context) => MediaQuery.of(context).size.width / 375;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

///TextTheme
TextStyle ptDisplay4(BuildContext context) => Theme.of(context).textTheme.display4;
TextStyle ptDisplay3(BuildContext context) => Theme.of(context).textTheme.display3;
TextStyle ptDisplay2(BuildContext context) => Theme.of(context).textTheme.display2;
TextStyle ptDisplay1(BuildContext context) => Theme.of(context).textTheme.display1;
TextStyle ptHeadline(BuildContext context) => Theme.of(context).textTheme.headline;
TextStyle ptTitle(BuildContext context) => Theme.of(context).textTheme.title;
TextStyle ptSubhead(BuildContext context) => Theme.of(context).textTheme.subhead;
TextStyle ptBody2(BuildContext context) => Theme.of(context).textTheme.body2;
TextStyle ptBody1(BuildContext context) => Theme.of(context).textTheme.body1;
TextStyle ptCaption(BuildContext context) => Theme.of(context).textTheme.caption;
TextStyle ptButton(BuildContext context) => Theme.of(context).textTheme.button;
TextStyle ptSubtitle(BuildContext context) => Theme.of(context).textTheme.subtitle;
TextStyle ptOverline(BuildContext context) => Theme.of(context).textTheme.overline;

///HeaderStyle
TextStyle ptHeadStyleText(BuildContext context) => Theme.of(context).textTheme.title.copyWith(fontSize: 20);

///FontStyle
class FONT {
  static const String Bold = "OpenSans-Bold";
  static const String BoldItalic = "OpenSans-BoldItalic";
  static const String ExtraBold = "OpenSans-ExtraBold";
  static const String ExtraBoldItalic = "OpenSans-ExtraBoldItalic";
  static const String Italic = "OpenSans-Italic";
  static const String Light = "OpenSans-Light";
  static const String LightItalic = "OpenSans-LightItalic";
  static const String Regular = "OpenSans-Regular";
  static const String SemiBold = "OpenSans-SemiBold";
  static const String SemiBoldItalic = "OpenSans-SemiBoldItalic";
}
