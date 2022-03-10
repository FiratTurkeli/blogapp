import 'package:blogapp/constant/text_style.dart';
import 'package:blogapp/data/controller/fav_controller.dart';
import 'package:blogapp/data/controller/get_account_controller.dart';
import 'package:blogapp/data/controller/get_blogs_controller.dart';
import 'package:blogapp/data/controller/get_categories_controller.dart';
import 'package:blogapp/constant/ui_helper.dart';
import 'package:blogapp/modules/blog_detail/detail_controller.dart';
import 'package:blogapp/modules/bottomnavigation/bottom_controller.dart';
import 'package:blogapp/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/controller/local_storage_controller.dart';

class HomePage extends GetView<HomeController> {

  final DetailController detailController = Get.put(DetailController());
  final FavController toogleFavController = Get.put(FavController());
  final GetBlogsController getBlogsController = Get.put(GetBlogsController());
  final GetCategoriesController getCategoriesController = Get.put(GetCategoriesController());
  final GetAccountController getAccountController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.7),
      appBar: AppBar(
          backgroundColor: Colors.blueGrey.withOpacity(0.7),
          title: const Text("Home", style: titleStyle,),
          centerTitle: true,
          leading: Builder(
              builder: (BuildContext context) {
                return IconButton(onPressed: () {},
                    icon: const Icon(Icons.search, color: Colors.white,));
              }
          )
      ),
      body: Container(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
          Expanded(
              flex: 1,
              child: Obx(() => getCategoriesController.isGetCatLoading.value
                  ? const Center(
                     child:  CircularProgressIndicator(color: Colors.orange))
                  : _categories(
                  getCategoriesController, getBlogsController))),

          UIHelper.verticalSpace(16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Blog',
                style: titleStyle,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Obx(() => getBlogsController.isGetBlogsLoading.value
                ? const Center(child: CircularProgressIndicator(color: Colors.orange))
                : _blogArticlesGridView()),
          ),
          ],
        ),
      ),
    );
  }


  ListView _categories(GetCategoriesController gc, GetBlogsController gb) {

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: gc.categories.value.data!.length,
      itemBuilder: (BuildContext context, int index) =>
          GestureDetector(
            onTap: () =>
                gb.getBlogs(
                    gc.categories.value.data![index].id,
                    PrefController().getToken()),
            child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 70,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Image.network(
                              gc.categories.value.data![index].image!, fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(gc.categories.value.data![index].title!, style: subtitleStyle,),
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          ),
    );
  }

  GridView _blogArticlesGridView() {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3/4,
        shrinkWrap: true,
        children:
        List.generate(getBlogsController.blogs.value.data!.length, (index) {
          return GestureDetector(
            onTap: () {
              detailController.selectedArticle.value = getBlogsController.blogs.value.data![index];
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
                  getBlogsController.blogs.value.data![index].image!,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                      height: 40,
                      width: 200,
                      color: Colors.grey.withOpacity(0.7),
                      padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                      child: Text(
                          getBlogsController.blogs.value.data![index].title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
                _favButton(index)
              ]),
            ),
          );
        }));
  }

  Widget _favButton(int index) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
          onPressed: () async {
            await toogleFavController.toggleFav(
                getBlogsController.blogs.value.data![index].id!, PrefController().getToken());
          },
          icon: Icon(Icons.favorite,
              color: getAccountController.favGetFavBlogList()
                  .contains(getBlogsController.blogs.value.data![index].id)
                  ? Colors.red
                  : Colors.white,
              size: 30)
      ),
    );
  }

}

