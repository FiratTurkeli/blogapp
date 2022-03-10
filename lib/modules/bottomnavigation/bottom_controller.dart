import 'package:blogapp/data/controller/get_account_controller.dart';
import 'package:blogapp/data/controller/local_storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomController extends GetxController {
  final pIndex = 1.obs;
  PageController pController = PageController(initialPage: 1, keepPage: true);
  final GetAccountController getAccountController=Get.find();

  @override
  void onInit() async {
    if(getAccountController.account.value.data==null) {
      await getAccountController.getAccount(PrefController().getToken());
    }
    pController = PageController(initialPage: pIndex.value, keepPage: true);
    super.onInit();
  }

  void pageindex(int value) {
    pIndex.value = value;
    pController.jumpToPage(value);
  }

  @override
  void dispose() {
    pController.dispose();
    super.dispose();
  }

}