import 'package:corona_tracker/json/countries.dart';
import 'package:corona_tracker/providers/home/home_controller.dart';
import 'package:corona_tracker/services/api.dart';
import 'package:flutter/material.dart';
class HomeLogic extends ChangeNotifier {
  HomeLogic(this._model);
  final HomeController _model;

  Future<void> init() async {
    _model.listCountries = await API.fetchData();
    if (_model.listCountries.isNotEmpty) {
      _model.selectedCountry = _model.listCountries[210];
    }
    _model.refresh();
  }

  void updateDataByCountry(Countries countries) async {
    _model.selectedCountry = countries;
    print(_model.selectedCountry.cases );
    _model.refresh();
  }
}
