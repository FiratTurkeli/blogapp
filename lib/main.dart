import 'package:blogapp/data/controller/local_storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Blog App",
        initialRoute: PrefController().getShared(),
        getPages: AppPages.routes,
        theme: ThemeData(backgroundColor: Colors.white)),
  );
}
