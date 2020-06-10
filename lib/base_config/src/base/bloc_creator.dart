import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corona_tracker/base_config/base_config.dart';

import 'base_bloc.dart';

mixin BlocCreator<T extends StatefulWidget> on State<T> {
  B createBloc<B>() {
    var appBloc = Provider.of<AppBloc>(context, listen: false);
    B bloc = Provider.of<B>(context);
    if (bloc is BaseBloc) {
      bloc.injectBloc(appBloc);
    }
    return bloc;
  }

  B findBloc<B>() {
    return Provider.of<B>(context);
  }
}