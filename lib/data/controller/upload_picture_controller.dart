import 'dart:io';
import 'package:get/get.dart';
import '../models/image_upload_model.dart';
import '../services/services.dart';
import 'get_account_controller.dart';

class UploadImageController extends GetxController {
  final uploadImage = UploadImageModel().obs;
  final isUploadImageLoading = true.obs;
  final GetAccountController accountController = Get.find();

  Future<void> uploadImageApi(File file, String filename, String token) async {
    try {
      isUploadImageLoading(true);
      uploadImage.value =
      await RemoteServices.uploadImage(file, filename, token);
    } finally {
      await accountController.getAccount(token);
      isUploadImageLoading(false);
    }
  }
}