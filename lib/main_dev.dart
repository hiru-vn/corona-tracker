import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as sv;
import 'package:corona_tracker/corona_tracker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sv.SystemChrome.setPreferredOrientations([sv.DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      DevicePreview(
        builder: (context) => CoronaTracker(),
      ),
    );
  });
}
