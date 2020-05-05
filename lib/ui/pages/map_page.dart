import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  GoogleMapController mapController;
  static final CameraPosition _myposition = new CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(14.092826, 108.785694),
      tilt: 59.440717697143555,
      zoom: 12);
  void _onMap(GoogleMapController mapController)
  {
    mapController = mapController;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map"),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMap,
          initialCameraPosition: _myposition,
          mapType: MapType.normal,
        )
    );
  }
}