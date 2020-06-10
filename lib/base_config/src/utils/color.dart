import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 8) {
      String hexOpacityColor = hexColor.substring(6);
      switch (hexOpacityColor) {
        case "95":
          hexOpacityColor = "F2";
          break;
        case "90":
          hexOpacityColor = "E6";
          break;
        case "85":
          hexOpacityColor = "D9";
          break;
        case "80":
          hexOpacityColor = "CC";
          break;
        case "75":
          hexOpacityColor = "BF";
          break;
        case "70":
          hexOpacityColor = "B3";
          break;
        case "65":
          hexOpacityColor = "A6";
          break;
        case "60":
          hexOpacityColor = "99";
          break;
        case "55":
          hexOpacityColor = "8C";
          break;
        case "50":
          hexOpacityColor = "80";
          break;
        case "45":
          hexOpacityColor = "73";
          break;
        case "40":
          hexOpacityColor = "66";
          break;
        case "35":
          hexOpacityColor = "59";
          break;
        case "30":
          hexOpacityColor = "4D";
          break;
        case "25":
          hexOpacityColor = "40";
          break;
        case "20":
          hexOpacityColor = "33";
          break;
        case "15":
          hexOpacityColor = "26";
          break;
        case "10":
          hexOpacityColor = "1A";
          break;
        case "05":
          hexOpacityColor = "0D";
          break;
        case "00":
          hexOpacityColor = "00";
          break;
        default:
          hexOpacityColor = "FF";
      }
      hexColor = hexOpacityColor + hexColor;
      hexColor = hexColor.substring(0, 8);
    } else if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class CustomColor {
  static const Color main = Color(0xff42bdf9);
  static const Color bg = Color(0xfff8f8f8);
  static const Color greyA = Color(0xF0F0F0FF);
  static const Color color2 = Color(0xFF2D3092);
  static const Color color3 = Color(0xAA9BEC79);
  static const Color color4 = Color(0xAAFFDC30);
  static const Color color5 = Color(0xAA18B0F1);
  static const Color color6 = Color(0xAA86DBFF);
  static const Color color7 = Color(0xAAFF6724);
}

class CustomColor2 {
  static Color primary = Color(0xFF42bdf9);
  static Color purple = Color(0xFF2D3092);
  static Color secondary = Color(0xFF9BEC79);
  static Color yellow = Color(0xFFFFDC30);
  static Color blue = Color(0xFF18B0F1);
  static Color greenblue = Color(0xFF86DBFF);
  static Color redorange = Color(0xFFFF6724);
  static Color grey = Color(0xFFD2D8CF);
}