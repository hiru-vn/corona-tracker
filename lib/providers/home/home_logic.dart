import 'package:corona_tracker/providers/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeLogic extends ChangeNotifier{
  HomeLogic(this._model);

  final HomeController _model;
}
