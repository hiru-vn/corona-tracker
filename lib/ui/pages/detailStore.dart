import 'package:corona_tracker/providers/home/home_controller.dart';
import 'package:corona_tracker/services/navigate_services.dart';
import 'package:corona_tracker/ui/pages/home_page.dart';
import 'package:corona_tracker/ui/pages/register_page.dart';
import 'package:corona_tracker/globals.dart' as globals;
import 'package:corona_tracker/ui/reuseable/spacing_box.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailStore extends StatefulWidget {
  final int id;
  DetailStore({@required this.id = 1});
  @override
  DetailStorePage createState() => DetailStorePage();
}

class DetailStorePage extends State<DetailStore> {
  String nameStore = "aaaaaa";
  String addressStore = "bbbbbbb";
  GoogleMapController mapController;
  String searchAddr;
  CameraPosition _mylocation =
      CameraPosition(target: LatLng(21, 105.8), zoom: 12);

  @override
  void initState() {
    super.initState();
    getStore(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Chi tiết'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/images/store.png',
                  width: 150, height: 150, fit: BoxFit.fill),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Thông tin cửa hàng",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFE5E5E5),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Tên cửa hàng: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(nameStore ?? '')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Địa chỉ: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                           // Container(child: Text(addressStore ?? '', maxLines: 3,))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(addressStore ?? '', maxLines: 3,),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Text(
                      //         "Thành phố: ",
                      //         style: TextStyle(
                      //             fontSize: 18, fontWeight: FontWeight.bold),
                      //       ),
                      //       Text(addressStore)
                      //     ],
                      //   ),
                      // )
                    ],
                  )),
              SpacingBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Vị trí cửa hàng:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  mapType: MapType.normal,
                  initialCameraPosition: _mylocation,
                ),
              ),
              SpacingBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getStore(int id) async {
    var dio = Dio();
    Response response;
    final baseURL = globals.baseURL + "/store/get";
    var data = {"id": id};
    response = await dio.get(baseURL, queryParameters: data);
    if (response.statusCode == 200) {
      setState(() {
        nameStore = response.data["data"]["name"];
        addressStore = response.data["data"]["address"];
      });
    }
  }
}
