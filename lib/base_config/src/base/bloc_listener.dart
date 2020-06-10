
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corona_tracker/base_config/base_config.dart';

class BlocListener<T extends BaseBloc> extends StatefulWidget {
  final Widget child;
  final Function(BaseEvent event) listener;

  BlocListener({
    @required this.child,
    @required this.listener,
  });

  @override
  _BlocListenerState createState() => _BlocListenerState<T>();
}

class _BlocListenerState<T> extends State<BlocListener> {
  var oldEvent;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var bloc = Provider.of<T>(context) as BaseBloc;
    bloc.processEventStream.listen(
      (newEvent) {
        if(oldEvent == newEvent) return;
        oldEvent = newEvent;
        widget.listener(newEvent);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<BaseEvent>.value(
      value: (Provider.of<T>(context) as BaseBloc).processEventStream,
      initialData: null,
      updateShouldNotify: (prev, current) {
        return false;
      },
      child: Consumer<BaseEvent>(
        builder: (context, event, child) {
          return Container(
            child: widget.child,
          );
        },
      ),
    );
  }
}