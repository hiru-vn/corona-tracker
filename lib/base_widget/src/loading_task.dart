
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:corona_tracker/base_config/base_config.dart';
import 'package:corona_tracker/base_widget/src/animations/scale_animation.dart';

class LoadingTask extends StatelessWidget {
  final Widget child;
  final BaseBloc bloc;
  final Color color;

  LoadingTask({
    @required this.child,
    @required this.bloc,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: bloc.loadingStream,
      initialData: false,
      child: Stack(
        children: <Widget>[
          child,
          Consumer<bool>(
            builder: (context, isLoading, child) => Container(
              height: SizeConfig.heightMultiplier * 80,
              width: SizeConfig.widthMultiplier * 100,
              child: Center(
                child: isLoading
                    ? ScaleAnimation(
                        child: Container(
                          width: SizeConfig.widthMultiplier * 30,
                          height: SizeConfig.widthMultiplier * 30,
                          decoration: new BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: SpinKitThreeBounce(
                            size: SizeConfig.widthMultiplier * 10,
                            color: color??CustomColor.main,
                            duration: Duration(milliseconds: 800),
                          ),
                        ),
                      )
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
