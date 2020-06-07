import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  GoogleMapController mapController;
  String searchAddr;
  CameraPosition _mylocation = CameraPosition(target: LatLng(21, 105.8), zoom:12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vị trí người nhiễm bệnh"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              mapType: MapType.normal,    
              myLocationEnabled: true,
              initialCameraPosition: _mylocation, 
              
            ),         
          ),
          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter address',
                  contentPadding: EdgeInsets.only(left: 15, top: 15),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search), 
                    onPressed: searchandNavigate,
                    iconSize: 30.0,)
                ),
              onChanged: (val){
                setState(){
                    searchAddr = val;
                }
              },
              )
            ),
          )
        ],
      ),
    );
  }
  searchandNavigate() {
    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
  }
  
}