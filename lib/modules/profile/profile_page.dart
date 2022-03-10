import 'dart:async';

import 'package:blogapp/constant/text_style.dart';
import 'package:blogapp/data/controller/get_account_controller.dart';
import 'package:blogapp/data/controller/get_account_update_controller.dart';
import 'package:blogapp/data/controller/local_storage_controller.dart';
import 'package:blogapp/constant/ui_helper.dart';
import 'package:blogapp/modules/bottomnavigation/bottom_controller.dart';
import 'package:blogapp/modules/profile/profile_controller.dart';
import 'package:blogapp/routes/app_pages.dart';
import 'package:blogapp/widgets/button1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/controller/upload_picture_controller.dart';
import '../../widgets/photo_sheet.dart';


class ProfilePage extends GetView<ProfileController> {
  final ProfileController controller = Get.put(ProfileController());
  final GetAccountController accountController = Get.put(GetAccountController());
  final GetAccountUpdeteController getAccountUpdeteController = Get.put(GetAccountUpdeteController());
  final UploadImageController uploadImageController = Get.put(UploadImageController());
  final PrefController prefController = Get.put(PrefController());

  Completer<GoogleMapController> mapControl = Completer();
  var initialPosition = const CameraPosition(target: LatLng(40.9903, 29.0205), zoom: 15);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<BottomController>().pageindex(1);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey.withOpacity(0.7),
          appBar: AppBar(
            backgroundColor: Colors.blueGrey.withOpacity(0.7),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left_rounded,
                  color: Colors.white, size: 35),
              onPressed: () => Get.find<BottomController>().pageindex(1),
            ),
            title: const Text('My Profile', style: titleStyle,),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [

                UIHelper.verticalSpace(16),

                Expanded(
                  child: Obx(() => _profileCircleImage()),
                ),

                UIHelper.verticalSpace(16),

                Expanded(
                    child: _showMap()),

                UIHelper.verticalSpace(16),

                Expanded(
                  child: _buttonColumn(context),
                )
              ],
            ),
          )),
    );
  }


  var startingLocation = CameraPosition(target: LatLng(38.7412482,26), zoom: 5);
  SizedBox _showMap() {
    return SizedBox(
      height: 250,
      width: 250,
      child: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: startingLocation,
        onMapCreated: (GoogleMapController controller){
          mapControl.complete(controller);
        },


      ),
    );
  }



  Column _buttonColumn(BuildContext context) {
    return Column(children: [
      _saveButton(context),

      UIHelper.verticalSpace(16),

      _logoutButton(context),
    ]);
  }

  Widget _profileCircleImage() {
    return Stack(children: [
      ClipOval(
          child: controller.isLoadingFinish.value == false
              ? const Center(child: CircularProgressIndicator(color: Colors.orange))
              : uploadImageController.uploadImage.value.data != null &&
              uploadImageController.isUploadImageLoading.value == false
              ? Image.network(uploadImageController.uploadImage.value.data!,
              width: Get.height * .22,
              height: Get.height * .22,
              fit: BoxFit.cover)
              : (accountController.account.value.data!.image != null &&
              accountController.account.value.data!.image != "string" &&
              accountController.account.value.data!.image != "")
              ? Image.network(accountController.account.value.data!.image,
              width: Get.height * .22,
              height: Get.height * .22,
              fit: BoxFit.cover)
              : Container(
              width: Get.height * .22,
              height: Get.height * .22,
              color: Colors.grey)),
      Positioned(
          bottom: Get.height * .07,
          right: Get.width * .03,
          child: IconButton(
              onPressed: () {
                CustomBottomSheetWidget.showBSheet(
                    context: Get.context,
                    controller: controller,
                    uploadImageController: uploadImageController);
              },
              icon: Icon(Icons.camera_alt, color: Colors.white, size: 40)))
    ]);
  }

  ButtonWidget1 _logoutButton(BuildContext context) {
    return ButtonWidget1(
      color: Colors.lightGreen,
      text: "Log Out",
      icon: Icons.output_outlined,
      tcolor: Colors.white,
      onClick: () async {
        Get.dialog(AlertDialog(
          backgroundColor: Colors.blueGrey.withOpacity(0.7),
          title: Text("Will be logged out?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            ButtonWidget1(
              text: "Logout",
              icon: Icons.logout_rounded,
              tcolor: Colors.white,
              onClick: () async {
                prefController.deleteFromPrefs();
                Get.offAllNamed(Routes.LOGIN);
              },
              color: Colors.lightGreen,
            ),

              UIHelper.verticalSpace(16),

            ButtonWidget1(
              text: "Cancel",
              icon: Icons.cancel,
              tcolor: Colors.lightGreen,
              onClick: () => Get.back(),
              color: Colors.white,
            )
            ],
          ),
        ));
      },

    );
  }

  ButtonWidget1 _saveButton(BuildContext context) {
    return ButtonWidget1(
      text: "Save",
      icon: Icons.save_alt_outlined,
      tcolor: Colors.lightGreen,
      onClick: () async {
        if (accountController.account.value.data != null) {
          await getAccountUpdeteController
              .updateAccount(uploadImageController.uploadImage.value.data,
              controller.longObs.value, controller.latObs.value,
              PrefController().getToken())
              .whenComplete(() =>
              Get.dialog(AlertDialog(
                backgroundColor: Colors.blueGrey.withOpacity(0.7),
                title: Text("Succesful!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightGreen)),
                content: Container(
                    width: Get.width * .5,
                    child: Text("Uptaded ! ",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white))),
                actions: [
                  Center(
                      child: ButtonWidget1(
                          icon: Icons.check_circle,
                          tcolor: Colors.white,
                          color: Colors.lightGreen,
                          text: "Done",
                          onClick: () => Get.back()))
                ],
              )));
        }
      },
      color: Colors.white,
    );
  }
}

//AIzaSyC2DSzITuWKKZp_nTfA_tITOMoLqXn2pDg