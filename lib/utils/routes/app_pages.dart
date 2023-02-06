import 'package:get/get.dart';
import 'package:humble_warrior/view/auth/login_binding.dart';
import 'package:humble_warrior/view/auth/login_screen.dart';
import 'package:humble_warrior/view/landing/intro_binding.dart';
import 'package:humble_warrior/view/landing/intro_screen.dart';

import 'app_routes.dart';

class AppPages {
  static String initialRoute = AppRoutes.introScreen;
  static final List<GetPage<dynamic>> routes = [
    GetPage(
        name: AppRoutes.introScreen,
        page: () => const IntroScreen(),
        binding: IntroBinding()),
    GetPage(
        name: AppRoutes.loginPage,
        page: () => const LoginScreen(),
        binding: LoginBinding())
  ];
}
