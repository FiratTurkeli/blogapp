part of "app_pages.dart";
abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const DETAIL = _Paths.DETAIL;
  static const PROFILE = _Paths.PROFILE;
  static const FAVORITES = _Paths.FAVORITES;
  static const REGISTER = _Paths.REGISTER;
  static const BOTTOM = _Paths.BOTTOM;
}

abstract class _Paths {
  static const HOME = "/home";
  static const LOGIN = "/login";
  static const DETAIL = "/detail";
  static const PROFILE = "/profile";
  static const FAVORITES = "/favorites";
  static const REGISTER ="/signup";
  static const BOTTOM = "/main";
}