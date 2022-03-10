import 'dart:async';

import 'package:blogapp/widgets/button1.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  Completer<GoogleMapController> mapControl = Completer();
  var startingLocation = CameraPosition(target: LatLng(38.7412482,26), zoom: 5);

  Future<void> getCurrentLocation() async {
    var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latd = location.latitude;
      lotd = location.longitude;
    });
    GoogleMapController controller = await mapControl.future;
    var targetLocation = CameraPosition(target: LatLng(latd,lotd), zoom: 8);
    controller.animateCamera(CameraUpdate.newCameraPosition(targetLocation));
  }

  double latd = 0.0;
  double lotd = 0.0;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 200,
      child: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onCameraMoveStarted: getCurrentLocation,
          mapType: MapType.hybrid,
          initialCameraPosition: startingLocation,
        onMapCreated: (GoogleMapController controller){
            mapControl.complete(controller);
        },
      ),
    );
  }
}

