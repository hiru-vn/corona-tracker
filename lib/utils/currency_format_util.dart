import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###");
      final number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }

  static String textToCurrency(String text) {
    var isNegative = false;
    if (text.contains('-')) {
      isNegative = true;
    }
    final number = int.parse(
        text.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll('[^\\d.]', ''));
    if (!isNegative) {
      return NumberFormat("#,###").format(number);
    }
    return "- " + NumberFormat("#,###").format(number);
  }

  static int currencyToInt(String text) {
    return int.parse(
        text.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll('[^\\d.]', ''));
  }
}
