import 'package:get/get.dart';

import '../models/blog_model.dart';
import '../services/services.dart';


class GetBlogsController extends GetxController {
  final blogs = GetBlogsModel().obs;
  final isGetBlogsLoading = true.obs;

  @override
  void onInit() {
    print("getblog init=> {$blogs.value}");
    super.onInit();
  }

  //Get Blogs method
  Future<void> getBlogs(String? id, String token) async {
    try {
      isGetBlogsLoading(true);
      blogs.value = await RemoteServices.getBlogs(id ?? "", token);
    } finally {
      isGetBlogsLoading(false);
    }
  }
}