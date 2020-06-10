// import 'package:corona_tracker/base_config/base_config.dart';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class BasePageContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget endDrawer;

  final List<SingleChildWidget> bloc;
  final List<SingleChildWidget> di;
  final List<Widget> actions;

  BasePageContainer({
    this.title,
    this.bloc,
    this.di,
    this.actions,
    this.child,
    this.endDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...di,
        ...bloc,
      ],
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: child),
      ),
    );
  }
}
