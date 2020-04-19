import 'package:corona_tracker/providers/qr/qr_controller.dart';
import 'package:flutter/material.dart';

class QrLogic extends ChangeNotifier{
  QrLogic(this._model);

  final QrController _model;
}
