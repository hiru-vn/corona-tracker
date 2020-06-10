import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class BaseWidgetContainer extends StatelessWidget {
  final Widget child;

  final List<SingleChildWidget> bloc;
  final List<SingleChildWidget> di;
  final List<Widget> actions;

  BaseWidgetContainer({
    this.bloc,
    this.di,
    this.actions,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...di,
        ...bloc,
      ],
      child: child,
    );
  }
}
