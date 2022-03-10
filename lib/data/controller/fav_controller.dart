import 'package:blogapp/data/services/services.dart';
import 'package:get/get.dart';

import '../models/favorite_model.dart';
import 'get_account_controller.dart';

class FavController extends GetxController {

  Future<void> toggleFav(String id,token) async {
    final favorites = ToggleFavoriteModel().obs;
    final isToggleFavsLoading = true.obs;
    final GetAccountController getAccountController=Get.put(GetAccountController());

    try {
      isToggleFavsLoading(true);
      favorites.value = await RemoteServices.toggleFavorites(id, token);
    } finally {
      await getAccountController.getAccount(token);
      isToggleFavsLoading(false);
    }
  }
}