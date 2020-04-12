import 'package:flutter/material.dart';

class GlobalModel extends ChangeNotifier {
  GlobalModel() {
    debugPrint('init GlobalModel');    
  }

  BuildContext context;

  // init App context
  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
    }
  }

  void refresh() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("remove global model");
  }
}
