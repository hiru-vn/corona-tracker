import 'package:corona_tracker/services/navigate_services.dart';
import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:flutter/material.dart';

import 'services/strings.dart';

class CoronaTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ResponsiveSize.init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName['vi'],
          theme: ThemeData(
            fontFamily: 'Quicksand',
            scaffoldBackgroundColor: const Color(0xFFFFFFFF)
          ),
          onGenerateRoute: generateRoute,
          navigatorKey: navigatorKey,
          initialRoute: Views.homePage,
        );
      });
    });
  }
}
