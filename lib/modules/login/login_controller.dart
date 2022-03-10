import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends TextEditingController {
  final email = "".obs;
  final password = "".obs;
  final isVisible = false.obs;

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please fill Email";
    } else if (value.length < 6) {
      return "İnvalid email type";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please fill password";
    } else if (value.length < 6) {
      return "Password must be minimum 6 character";
    } else {
      return null;
    }
  }
}