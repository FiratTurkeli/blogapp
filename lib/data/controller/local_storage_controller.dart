import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_pages.dart';

class PrefController extends GetxController {
  final box = GetStorage();
  final token = "".obs;
  final image = "".obs;
  final isLogin = false.obs;

  @override
  Future<void> onInit() async {
    if (box.read("login") != null) {
      await _loadFromPrefs();
      print('first: ${box.read("token")}');
    }
    super.onInit();
  }

  String getToken() {
    return box.read("token");
  }

  String getShared() {
    return isRemember()
        ? Routes.BOTTOM
        : Routes.LOGIN;
  }

  bool isRemember() {
    return box.read("login") ?? false;
  }


  _initPrefs() async {
    await GetStorage.init();
  }

  saveToPrefs() async {
    await _initPrefs();
    box.write("login", isLogin.value);
    box.write("token", token.value);
    box.write("image", image.value);
  }

  _loadFromPrefs() async {
    isLogin.value = box.read("login") as bool;
    token.value = box.read("token");
    image.value = box.read("image");
    await _initPrefs();
  }

  deleteFromPrefs() async {
    await _initPrefs();
    box.remove("login");
    box.remove("token");
    box.remove("image");
  }

}