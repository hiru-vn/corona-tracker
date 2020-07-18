import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:corona_tracker/globals.dart' as globals;

class MapPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapPage> {
  static List<Marker> allMarkers = [];
  String searchAddr;
  GoogleMapController _controller;
  static Future<void> fetchData() async {
    var dio = Dio();
    String baseURL = globals.baseURL + "/user/getInfected";
    var res = await dio.get(baseURL);
    if (res.statusCode == 200) {
      var jsonData = res.data;
      for (var i in jsonData['data']) {
        allMarkers.add(Marker(
            markerId: MarkerId(i['fullName']),
            draggable: true,
            consumeTapEvents: true,
            infoWindow: InfoWindow(
              title: i['fullName'],
              snippet: "Nhiem benh",
              onTap: () {},
            ),
            onTap: () {},
            position: LatLng(i['lat']['Float64'], i['long']['Float64'])));
      }
      //print(allMarkers.toString());
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(10.8818405848783, 106.80895879040649),
                zoom: 16.0),
            markers: Set<Marker>.of(allMarkers),
            onMapCreated: mapCreated,
            myLocationEnabled: true,
          ),
        ),
        Positioned(
          top: 30.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter Address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: searchandNavigate,
                      iconSize: 30.0)),
              onChanged: (val) {
                setState(() {
                  searchAddr = val;
                });
              },
            ),
          ),
        ),
      ]),
    );
  }

  searchandNavigate() {
    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
