import 'package:corona_tracker/providers/home/home_logic.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    logic = HomeLogic(this);
  }

  HomeLogic logic;

  void refresh() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("remove HomeController");
  }
}