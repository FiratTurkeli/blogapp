import 'package:blogapp/data/controller/fav_controller.dart';
import 'package:blogapp/data/controller/get_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/controller/local_storage_controller.dart';
import '../bottomnavigation/bottom_controller.dart';

class FavoritesPage extends GetView<FavController> {

  final FavController favController = Get.put(FavController());
  final GetAccountController getAccountController=Get.find();

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
            icon:
            Icon(Icons.chevron_left_rounded, color: Colors.white, size: 35),
            onPressed: () => Get.find<BottomController>().pageindex(1),
          ),
          title: Text('My Favorites'),
          centerTitle: true,
        ),
        body: Obx(() => getAccountController.favGetFavBlogList().isEmpty
            ? const Center(
            child: Text("No favorites yet !",
                style: TextStyle(fontSize: 25, color: Colors.white)))
            : getAccountController.isGetAccountLoading.value
            ? const Center(child: CircularProgressIndicator(color: Colors.orange))
            : _blogArticlesGridView()),
      ),
    );
  }

  GridView _blogArticlesGridView() {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3/4,
        shrinkWrap: true,
        children:
        List.generate(getAccountController.favGetFavBlogList().length, (index) {
          return GestureDetector(
            onTap: () {
              Get.find<BottomController>().pController.jumpToPage(3);
            },
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(fit: StackFit.passthrough, children: [
                Image.network(
                  getAccountController.favGetFavBlogList()[index].image!,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                      height: 40,
                      width: 200,
                      color: Colors.grey.withOpacity(0.5),
                      padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                      child: Text(getAccountController.favGetFavBlogList()[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () async {
                          await favController.toggleFav(getAccountController.favGetFavBlogList()[index].id,PrefController().getToken());
                        },
                        icon:
                        const Icon(Icons.favorite, color: Colors.red, size: 30))),
              ]),
            ),
          );
        }));
  }
}