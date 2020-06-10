import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

showUndoneFeature(BuildContext context) {
  Alert(
    context: context,
    title: "Tính năng này chưa có",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.redAccent,
      ),
    ],
  ).show();
  return;
}
