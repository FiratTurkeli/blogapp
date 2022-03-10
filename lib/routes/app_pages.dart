import 'package:blogapp/modules/blog_detail/detail_binding.dart';
import 'package:blogapp/modules/blog_detail/detail_page.dart';
import 'package:blogapp/modules/bottomnavigation/bottom_binding.dart';
import 'package:blogapp/modules/bottomnavigation/bottom_navigation_page.dart';
import 'package:blogapp/modules/favorites/favorites_bindings.dart';
import 'package:blogapp/modules/favorites/favorites_page.dart';
import 'package:blogapp/modules/home/home_binding.dart';
import 'package:blogapp/modules/home/home_screen.dart';
import 'package:blogapp/modules/login/login_binding.dart';
import 'package:blogapp/modules/login/login_screen.dart';
import 'package:blogapp/modules/profile/profile_bindings.dart';
import 'package:blogapp/modules/profile/profile_page.dart';
import 'package:blogapp/modules/register/register_binding.dart';
import 'package:blogapp/modules/register/register_page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => FavoritesPage(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM,
      page: () => BottomPage(),
      binding: BottomBinding(),
    ),
  ];
}