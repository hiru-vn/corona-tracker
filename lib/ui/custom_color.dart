import 'package:flutter/material.dart';

class CustomColor {
  static const Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  static const MaterialColor yellow = MaterialColor(0xffffde03, color);
  static const MaterialColor blue = MaterialColor(0xff0336ff, color);
  static const MaterialColor primary = MaterialColor(0xff26934F, color);
  static const MaterialColor secondary = MaterialColor(0xffFFC90A, color);
  static const Color alert = Color.fromRGBO(255, 40, 40, 1);
  static const Color lightText = Colors.white;
  static const Color secondaryLight = Color.fromRGBO(247, 247, 0, .5);
  static const Color cardBody = Color.fromRGBO(233, 233, 233, 1);
}
