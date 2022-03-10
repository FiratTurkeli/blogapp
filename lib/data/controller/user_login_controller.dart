import 'package:blogapp/data/controller/get_blogs_controller.dart';
import 'package:get/get.dart';

import '../models/login_model.dart';
import '../services/services.dart';
import 'get_account_controller.dart';
import 'get_categories_controller.dart';
import 'local_storage_controller.dart';

class UserLoginController extends GetxController {
  final user = UserLoginModel().obs;
  final isLoginLoading = true.obs;

  final PrefController prefController = Get.put(PrefController());
  final GetBlogsController blogsController= Get.put(GetBlogsController());
  final GetCategoriesController categoriesController= Get.put(GetCategoriesController());
  final GetAccountController accountController= Get.put(GetAccountController());


  setToken(String token) async {
    if (prefController.token.value != "") {
      await _initLoad(token);
    } else {
      prefController.token.value = token;
      prefController.isLogin.value = true;
      prefController.saveToPrefs();
      await _initLoad(token);
    }
  }

  _initLoad(String token) async {
    await blogsController.getBlogs("", token);
    await categoriesController.getCategories(token);
    await accountController.getAccount(token);
  }

  Future<void> login(String email, String password) async {
    try {
      isLoginLoading(true);
      user.value = await RemoteServices.userLogin(email, password);
    } finally {
      if (user.value.hasError == false) {
        await setToken(user.value.data!.token!);
      }

      isLoginLoading(false);
    }
  }
}