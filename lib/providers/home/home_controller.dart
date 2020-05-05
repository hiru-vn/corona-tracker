import 'package:corona_tracker/json/countries.dart';
import 'package:corona_tracker/providers/home/home_logic.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    logic = HomeLogic(this);
    logic.init();
  }


  HomeLogic logic;
  bool isLoading = false;
  List<Countries> listCountries = <Countries>[];
  Countries selectedCountry;

  void refresh() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("remove HomeController");
  }
}