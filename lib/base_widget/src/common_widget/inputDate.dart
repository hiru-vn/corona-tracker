import 'dart:async';

import 'package:flutter/material.dart';
import 'package:corona_tracker/base_config/base_config.dart';

class InputDateDropdown extends StatelessWidget {
  const InputDateDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueStyle,
      this.onPressed,
      this.lableStyle,
      this.valueText})
      : super(key: key);

  final String labelText;
  final TextStyle lableStyle;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: lableStyle,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText,
                style: valueStyle),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}

Future<void> selectStartDate(
    {BuildContext context,
    DateTime initDate,
    Sink<DateTime> date}) async {
  final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: ptPrimaryColor(context),
              accentColor: ptPrimaryColor(context)),
          child: child,
        );
      },
      context: context,
      initialDate: initDate == null ? DateTime.now() : initDate,
      firstDate: DateTime(1950, 8),
      lastDate: DateTime.now());
  date.add(picked);
}
