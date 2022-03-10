import 'package:blogapp/data/controller/get_account_controller.dart';
import 'package:blogapp/modules/blog_detail/detail_page.dart';
import 'package:blogapp/modules/bottomnavigation/bottom_controller.dart';
import 'package:blogapp/modules/home/home_screen.dart';
import 'package:blogapp/modules/profile/profile_page.dart';
import 'package:blogapp/widgets/fav_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/internet_controller.dart';
import '../favorites/favorites_page.dart';

class BottomPage extends GetView<BottomController> {

  final List<Widget> pages = [FavoritesPage(), HomePage(), ProfilePage(), DetailPage()];

  @override
  Widget build(BuildContext context) {
    final NetController netContoller = Get.put(NetController());
    final GetAccountController getAccountController=Get.put(GetAccountController());

    if (controller.pController.hasClients) {
      controller.onClose();
      controller.onInit();
    }
    return Scaffold(
        body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pController,
            children: pages
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) => controller.pageindex(value),
          currentIndex: controller.pIndex.value,
          selectedItemColor: Colors.lightGreen,
          iconSize: 30,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 15,
          unselectedFontSize: 10,
          items:  [
            BottomNavigationBarItem(
                icon: FavIconButton(
                  iconData: Icons.favorite,
                  notificationCount: getAccountController.favGetFavBlogList().length,
                ),
                label: "Favorite"
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile"
            )
          ],
        )
        )
    );
  }


}