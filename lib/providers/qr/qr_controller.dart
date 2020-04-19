import 'package:corona_tracker/providers/qr/qr_logic.dart';
import 'package:flutter/material.dart';

class QrController extends ChangeNotifier {
  QrController() {
    logic = QrLogic(this);
  }

  QrLogic logic;

  void refresh() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("remove QrController");
  }
}