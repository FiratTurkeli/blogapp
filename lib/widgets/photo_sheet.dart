import 'dart:io';
import 'package:blogapp/data/controller/local_storage_controller.dart';
import 'package:blogapp/data/controller/upload_picture_controller.dart';
import 'package:blogapp/constant/ui_helper.dart';
import 'package:blogapp/modules/profile/profile_controller.dart';
import 'package:blogapp/widgets/button1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomBottomSheetWidget {
  static void showBSheet(
      {required BuildContext? context,
        required UploadImageController uploadImageController,
        required ProfileController controller}) {
    Get.bottomSheet(
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.7),
            boxShadow: const [
               BoxShadow(
                color: Colors.white,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius:  const BorderRadius.only(
              topRight:  Radius.circular(20),
              topLeft:  Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Expanded(
                flex: 5,
                child: _imagePreview(controller),
              ),
              UIHelper.verticalSpace(16),
              Expanded(child: _buttonGroup(controller, uploadImageController)),
              UIHelper.verticalSpace(16)
            ]),
          ),
        ),
        elevation: 5
    );
  }

  static Widget _imagePreview(ProfileController controller) {
    return Obx(() => Stack(alignment: Alignment.center, children: [
      Container(
          width: Get.width * .9,
          height: Get.height * .5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: controller.imageFileList!.isEmpty
              ? const SizedBox.shrink()
              : Image.file(File(controller.imageFileList!.first.path),
              fit: BoxFit.cover)),
      Visibility(
        visible: controller.imageFileList!.isEmpty,
        child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: 60,
            onPressed: () => Get.dialog(AlertDialog(
              backgroundColor: Colors.blueGrey.withOpacity(0.7),
              title: const Text("Select a Picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightGreen)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWidget1(
                    text: "Camera",
                    icon: Icons.camera_alt_rounded,
                    tcolor: Colors.white,
                    onClick: () => controller.openSelectedPicker(
                        Get.context!, ImageSource.camera),
                    color: Colors.lightGreen,
                  ),
                  UIHelper.verticalSpace(16),
                  ButtonWidget1(
                    text: "Gallery",
                    icon: Icons.photo_library,
                    tcolor: Colors.lightGreen,
                    onClick: () => controller.openSelectedPicker(
                        Get.context!, ImageSource.gallery),
                    color: Colors.white,
                  )
                ],
              ),
            )),
            icon: const Icon(Icons.camera_alt_rounded, color: Colors.lightGreen)),
      )
    ]));
  }

  static Row _buttonGroup(
      ProfileController controller, UploadImageController uploadImageController) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            child: ButtonWidget1(
              text: "Select",
              color: Colors.lightGreen,
              icon: Icons.touch_app_rounded,
              tcolor: Colors.white,
              onClick: () async {
                if (controller.isSelected.value == false) {
                  Get.dialog(AlertDialog(
                    title: const Text("Warning..!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red)),
                    content: Container(
                        width: Get.width * .5,
                        child:  const Text("No selected Image File...",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.lightGreen))),
                    actions: [
                      Center(
                          child: ButtonWidget1(
                              icon: Icons.check_circle,
                              tcolor: Colors.white,
                              color: Colors.lightGreen,
                              text: "Done",
                              onClick: () => Get.back()))
                    ],
                  ));
                } else {
                  final image = controller.imageFileList!.first.path;
                  controller.isSelected.value = true;
                  await uploadImageController.uploadImageApi(File(image), image,PrefController().getToken());
                  controller.imageFileList!.clear();
                  Get.back();
                }
              },
            ),
          ),
          UIHelper.horizontalSpace(16),
          SizedBox(
            width: 160,
            child: ButtonWidget1(
              text: "Remove",
              icon: Icons.delete_forever_rounded,
              tcolor: Colors.lightGreen,
              onClick: () {
                controller.isSelected.value = false;
                controller.imageFileList!.clear();
              },
              color: Colors.white,
            ),
          )
        ]);
  }
}