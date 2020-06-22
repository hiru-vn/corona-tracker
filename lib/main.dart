import 'package:corona_tracker/corona_tracker.dart';
import 'package:corona_tracker/json/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // List add = AddressVn.getJsonData();
  // for(int i=0; i< add.length; i++) {
  //   print("INSERT into \"CITY\"(id, name) VALUES (${add[i]["pid"]}, '${add[i]["pn"]}')");
  // }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(CoronaTracker());
  });
}



