import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final isLoadingFinish = true.obs;
  final isRequiredPermission = false.obs;
  final List<Marker> markers = <Marker>[].obs;
  final updateLatLng = [].obs;
  final dragMarkerPosition = false.obs;
  final latObs = 0.0.obs;
  final longObs = 0.0.obs;

  Position? currentLocation;
  CameraPosition? currentLatLng;
  late GoogleMapController mapController;

  @override
  void onInit() {
    getterLocations();
    super.onInit();
  }

  Future<Position?> getLocation() async {
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      return null;
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .catchError((e) {
      print(e);
    });
  }

  void permissionOK() async {
    getLocation().then((pos) {
      if (pos == null) {
        isRequiredPermission.value = true;
        isLoadingFinish.value = false;
      } else {
        currentLocation = pos;

        latObs.value = pos.latitude;
        longObs.value = pos.longitude;

        markers.add(Marker(
            draggable: true,
            onDragEnd: ((newLatLng) {
              updateLatLng.clear();
              updateLatLng.add(newLatLng.latitude);
              updateLatLng.add(newLatLng.longitude);
              dragMarkerPosition.value = true;
            }),
            markerId: MarkerId('Current Location'),
            position:
            LatLng(currentLocation!.latitude, currentLocation!.longitude),
            infoWindow: InfoWindow(title: 'Konumunuz')));
        currentLatLng = CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 14.4746,
        );
        mapController
            .animateCamera(CameraUpdate.newCameraPosition(currentLatLng!));
        isRequiredPermission.value = false;
        isLoadingFinish.value = true;
      }
    });
  }

  void longPress(newLatLng) {
    updateLatLng.clear();
    updateLatLng.add(newLatLng.latitude);
    updateLatLng.add(newLatLng.longitude);
  }

  void getterLocations() async {
    Geolocator.requestPermission().then((request) {
      if (GetPlatform.isIOS || GetPlatform.isAndroid) {
        if (request == LocationPermission.denied ||
            request == LocationPermission.deniedForever) {
          return;
        } else {
          permissionOK();
        }
      }
    });
  }



  final isSelected = false.obs;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = <XFile>[].obs;

  void openSelectedPicker(BuildContext context, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      Get.back();
      if (pickedFile != null) {
        isSelected.value = true;
        imageFileList?.add(pickedFile);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}