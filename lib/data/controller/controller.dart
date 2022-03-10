import 'dart:io';
import 'package:get/get.dart';
import '../../modules/favorites/favorites_controller.dart';
import '../models/account_model.dart';
import '../models/blog_model.dart';
import '../models/category_model.dart';
import '../models/favorite_model.dart';
import '../models/image_upload_model.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/update_model.dart';
import '../services/services.dart';
import 'local_storage_controller.dart';

class ApiController extends GetxController {
  final user = UserLoginModel().obs; //
  final categories = GetCategoriesModel().obs; //
  final blogs = GetBlogsModel().obs; //
  final favorites = ToggleFavoriteModel().obs;
  final account = AccountModel().obs; //
  final upAccount = AccountUpdateModel().obs;//
  final newUser = SignUpModel().obs;
  final uploadImage = UploadImageModel().obs;//

  final accountItem = [].obs;
  final isLoginLoading = true.obs; //
  final isGetCatLoading = true.obs; //
  final isGetBlogsLoading = true.obs; //
  final isToggleFavsLoading = true.obs;//
  final isGetAccountLoading = true.obs; //
  final isRegisterLoading = true.obs;
  final isUploadImageLoading = true.obs;//

  final logout = false.obs;
  var token = "";

  final PrefController prefController = Get.put(PrefController());
  final FavoritesController favoritesController = Get.put(FavoritesController());

  setToken() async {
    if (prefController.token.value != "") {
      token = prefController.token.value;
      await _initLoad();
    } else {
      token = user.value.data!.token!;
      await _initLoad();
    }
  }

  _initLoad() async {
    await getBlogs("");
    await getCategories();
    await getAccount();
  }

  Future<void> login(String email, String password) async {
    token = "";
    try {
      isLoginLoading(true);
      user.value = await RemoteServices.userLogin(email, password);
    } finally {
      if (user.value.hasError == false) {
        await setToken();
      }

      isLoginLoading(false);
    }
  }

  Future<void> signUp(String email, String password, String password2) async {
    try {
      isRegisterLoading(true);
      newUser.value = await RemoteServices.signUp(email, password, password2);
    } finally {
      await login(email, password).whenComplete(() => getAccount());
      await getBlogs("");
      await getCategories();
      isRegisterLoading(false);
    }
  }

  Future<void> getAccount() async {
    try {
      isGetAccountLoading(true);
      account.value = await RemoteServices.getAccounts(token);
    } finally {
      if (account.value.data!.favoriteBlogIds.isEmpty) {
      } else {
        account.value.data!.favoriteBlogIds;
      }
      isGetAccountLoading(false);
    }
  }

  Future<void> updateAccount(img, lng, ltd) async {
    try {
      isGetAccountLoading(true);
      upAccount.value = await RemoteServices.updateAccounts(
          img, lng.toString(), ltd.toString(), token);
    } finally {
      await getAccount();
      isGetAccountLoading(false);
    }
  }

  Future<void> getCategories() async {
    try {
      isGetCatLoading(true);
      categories.value = await RemoteServices.getCategories(token);
    } finally {
      isGetCatLoading(false);
    }
  }

  Future<void> getBlogs(String? id) async {
    try {
      isGetBlogsLoading(true);
      blogs.value = await RemoteServices.getBlogs(id ?? "", token);
    } finally {
      isGetBlogsLoading(false);
    }
  }

  Future<void> toggleFav(String id) async {
    try {
      isToggleFavsLoading(true);
      favorites.value = await RemoteServices.toggleFavorites(id, token);
    } finally {
      await getAccount();
      isToggleFavsLoading(false);
    }
  }

  Future<void> uploadImageApi(File file, String filename) async {
    try {
      isUploadImageLoading(true);
      uploadImage.value =
      await RemoteServices.uploadImage(file, filename, token);
    } finally {
      await getAccount();
      isUploadImageLoading(false);
    }
  }


}