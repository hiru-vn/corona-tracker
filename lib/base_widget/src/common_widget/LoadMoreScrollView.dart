import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corona_tracker/base_config/base_config.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

class LoadMoreEvent extends BaseEvent {
  LoadMoreEvent();
}

class LoadMoreScrollView extends StatelessWidget {
  final BaseBloc bloc;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Widget noDataWidget;
  final ScrollPhysics physics;

  LoadMoreScrollView(
      {@required this.bloc,
      @required this.itemCount,
      @required this.itemBuilder,
      this.physics,
      this.noDataWidget});

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.endScrollStream,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollEndNotification &&
              _scrollController.position.extentAfter == 0) {
            bloc.event.add(LoadMoreEvent());
          }
          if (scrollInfo.metrics.pixels < scrollInfo.metrics.maxScrollExtent) {
            bloc.endScrollSink.add(false);
          }
        },
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: physics,
                controller: _scrollController,
                itemBuilder: itemBuilder,
                itemCount: itemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
