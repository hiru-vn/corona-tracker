import 'package:corona_tracker/json/countries.dart';
import 'package:corona_tracker/providers/home/home_controller.dart';
import 'package:corona_tracker/services/api.dart';
import 'package:flutter/material.dart';

class HomeLogic extends ChangeNotifier {
  HomeLogic(this._model);



  final HomeController _model;

  Future getData() async {
    API.fetchData();
  }


  Future updateDataByCountry(String countries) async {
    var data = await API.fetchData();
    _model.isLoading = true;
    print(_model.isLoading);
    _model..refresh();

    for (var i in data) {
      if (countries == i.country) {
        _model.cases = i.cases;
        _model.deaths = i.deaths;
        _model.recovered = i.recovered;
        print(_model.cases);
      }
    }
    _model.isLoading = false;
     _model..refresh();
  }


}
