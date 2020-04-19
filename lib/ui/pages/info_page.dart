import 'package:corona_tracker/services/navigate_services.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () => navigatorKey.currentState.pushNamed(Views.qrPage),
          child: const Text('Scan'),
        ),
      ),
    );
  }
}