import 'package:get/get.dart';

import '../models/account_model.dart';
import '../services/services.dart';
import 'get_blogs_controller.dart';

class GetAccountController extends GetxController {
  final account = AccountModel().obs;
  final isGetAccountLoading = true.obs;
  final GetBlogsController getBlogsController = Get.put(GetBlogsController());

  Future<void> getAccount(String token) async {
    try {
      isGetAccountLoading(true);
      account.value = await RemoteServices.getAccounts(token);
    } finally {
      favGetFavBlogList();
      isGetAccountLoading(false);
    }
  }

  List favGetFavBlogList() {
    var favoriteBlog = [];
    if (account.value.data!.favoriteBlogIds.isEmpty) {
      return favoriteBlog = [];
    } else {
      for (var favorite in account.value.data!.favoriteBlogIds) {
        for (var article in getBlogsController.blogs.value.data!) {
          if (favorite == article.id) {
            favoriteBlog.add(article);
          }
        }
      }
      return favoriteBlog;
    }
  }
}