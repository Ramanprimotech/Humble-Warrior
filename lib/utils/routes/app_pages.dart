import 'package:get/get.dart';
import 'package:humble_warrior/view/about_donna/about_screen.dart';
import 'package:humble_warrior/view/auth/login_binding.dart';
import 'package:humble_warrior/view/auth/login_screen.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_binging.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_screen.dart';
import 'package:humble_warrior/view/home_option/home_option_binging.dart';
import 'package:humble_warrior/view/home_option/home_option_screen.dart';
import 'package:humble_warrior/view/landing/intro_binding.dart';
import 'package:humble_warrior/view/landing/intro_screen.dart';
import 'package:humble_warrior/view/my_account/my_account_screen.dart';
import 'package:humble_warrior/view/splash/splash_binding.dart';
import 'package:humble_warrior/view/splash/splash_screen.dart';

import '../../view/about_donna/about_binding.dart';
import '../../view/my_account/my_account_binding.dart';
import '../../view/productDetail/product_detail_Screen.dart';
import '../../view/productDetail/product_detail_binding.dart';
import 'app_routes.dart';

class AppPages {
  static String initialRoute = AppRoutes.splashScreen;
  static final List<GetPage<dynamic>> routes = [
    GetPage(
        name: AppRoutes.introScreen,
        page: () => const IntroScreen(),
        binding: IntroBinding()),
    GetPage(
        name: AppRoutes.loginPage,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.bottomNavigation,
        page: () => const BottomNavigationScreen(),
        binding: BottomNavigationBindings()),
    GetPage(
        name: AppRoutes.homeOptions,
        page: () => const HomeOptionScreen(),
        binding: HomeOptionBindings()),
    GetPage(
        name: AppRoutes.productDetail,
        page: () => const ProductDetailScreen(),
        binding: ProductDetailBinding()),
    GetPage(
        name: AppRoutes.aboutDonna,
        page: () => const AboutScreen(),
        binding: AboutBinding()),
    GetPage(
        name: AppRoutes.splashScreen,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.myAccount,
        page: () =>  const MyAccount(),
        binding: MyAccountBindings())
  ];
}
