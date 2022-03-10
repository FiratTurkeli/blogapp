import 'package:get/get.dart';
import '../models/update_model.dart';
import '../services/services.dart';
import 'get_account_controller.dart';

class GetAccountUpdeteController extends GetxController {
  final upAccount = AccountUpdateModel().obs;
  final isGetAccountLoading = true.obs; //
  final GetAccountController accountController=Get.find();


  Future<void> updateAccount(img, lng, ltd,token) async {
    try {
      isGetAccountLoading(true);
      upAccount.value = await RemoteServices.updateAccounts(
          img, lng.toString(), ltd.toString(),token);
    } finally {
      await accountController.getAccount(token);
      isGetAccountLoading(false);
    }
  }

}