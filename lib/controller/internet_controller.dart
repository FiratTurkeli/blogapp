import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final _isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    startMonitoring();
  }

  bool get isOnline => _isOnline.value;

  Future<bool?> startMonitoring() async {
    _connectivity.onConnectivityChanged.listen((
        result,
        ) async {
      if (result == ConnectivityResult.none) {
        _isOnline.value = false;
        netErrorSnackBar();
      } else if (!GetPlatform.isWeb) {
        await _updateConnectionStatus().then((isConnected) {
          _isOnline.value = isConnected!;
        });
      }
    });
    return null;
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
        _isOnline.value = false;
        netErrorSnackBar();
      } else {
        _isOnline.value = true;
      }
    } on PlatformException catch (e) {
      print("PlatformException: $e");
    }
  }

  Future<bool?> _updateConnectionStatus() async {
    bool? isConnected;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      netErrorSnackBar();
    }
    return isConnected;
  }
}

int d = 0;
netErrorSnackBar() {
  d += 1;
  if (NetController().isOnline == false && d == 1) {
    Get.snackbar(
      "WARNING..!",
      'You are not connected to the internet.\n Make sure Wi-Fi is or Mobile Data on, Airplane Mode is Off and try again.',
      icon: const Icon(Icons.wifi_off_rounded, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 80),
      colorText: Colors.white,
      isDismissible: true,
      duration: const Duration(seconds: 5),
      dismissDirection: DismissDirection.up,
      forwardAnimationCurve: Curves.fastOutSlowIn,
    );
    d = 0;
  }
}