import 'package:blogapp/data/services/services.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class GetCategoriesController extends GetxController {
  final categories = GetCategoriesModel().obs;
  final isGetCatLoading = true.obs;


  Future<void> getCategories(String token) async {
    try {
      isGetCatLoading(true);
      categories.value = await RemoteServices.getCategories(token);
    } finally {
      isGetCatLoading(false);
    }
  }
}