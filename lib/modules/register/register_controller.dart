import 'package:get/get.dart';

class RegisterController extends GetxController {
  final email = "".obs;
  final password = "".obs;
  final passwordRetry = "".obs;
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

  String? validatePasswordRetry(String? value) {
    if (value!.isEmpty) {
      return "Please fill password";
    } else if (value.length < 6) {
      return "Password retry must be minimum character";
    } else if(value=="not equal"){
      return "Passwords are not equal";
    }else {
      return null;
    }
  }
}