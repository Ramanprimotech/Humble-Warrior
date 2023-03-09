import 'package:get/get.dart';
import 'package:humble_warrior/view/about_donna/about_screen.dart';
import 'package:humble_warrior/view/auth/login_binding.dart';
import 'package:humble_warrior/view/auth/login_screen.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_binging.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_screen.dart';
import 'package:humble_warrior/view/brands/brands_binding.dart';
import 'package:humble_warrior/view/brands/brands_screen.dart';
import 'package:humble_warrior/view/home_option/home_options_main/home_option_binging.dart';
import 'package:humble_warrior/view/landing/intro_binding.dart';
import 'package:humble_warrior/view/landing/intro_screen.dart';
import 'package:humble_warrior/view/my_account/account_details/account_details_binding.dart';
import 'package:humble_warrior/view/my_account/account_details/account_details_screen.dart';
import 'package:humble_warrior/view/my_account/my_account_screen.dart';
import 'package:humble_warrior/view/notification/notification_binding.dart';
import 'package:humble_warrior/view/notification/notification_screen.dart';
import 'package:humble_warrior/view/productDetail/category_details_list/category_details_list_binding.dart';
import 'package:humble_warrior/view/productDetail/category_details_list/category_details_list_screen.dart';
import 'package:humble_warrior/view/productDetail/category_item_detail/category_item_detail_binding.dart';
import 'package:humble_warrior/view/productDetail/category_item_detail/category_item_detail_screen.dart';
import 'package:humble_warrior/view/productDetail/daily_deals_details_screen/daily_deal_product.dart';
import 'package:humble_warrior/view/productDetail/daily_deals_details_screen/daily_deal_product_binding.dart';
import 'package:humble_warrior/view/productDetail/donna_favourite_details_screen/favourite_deals.dart';
import 'package:humble_warrior/view/sorting/sort_binding.dart';
import 'package:humble_warrior/view/sorting/sort_screen.dart';
import 'package:humble_warrior/view/splash/splash_binding.dart';
import 'package:humble_warrior/view/splash/splash_screen.dart';
import 'package:humble_warrior/view/static_pages/static_page_binding.dart';
import 'package:humble_warrior/view/static_pages/static_page_screen.dart';

import '../../view/about_donna/about_binding.dart';
import '../../view/home_option/home_options_main/home_option_screen.dart';
import '../../view/my_account/my_account_binding.dart';
import '../../view/productDetail/donna_favourite_details_screen/favourite_deals_binding.dart';
import '../../view/productDetail/front_page_details_screen/front_page_detail_binding.dart';
import '../../view/productDetail/front_page_details_screen/front_page_detail_screen.dart';
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
        name: AppRoutes.dailyDealProductDetail,
        page: () => DailyDealProduct(),
        binding: DailyDealProductBinding()),
    GetPage(
        name: AppRoutes.frontPageProductDetail,
        page: () => FrontPageDetailScreen(),
        binding: FrontPageDetailBinding()),
    GetPage(
        name: AppRoutes.favouriteDeal,
        page: () => const FavouriteDeals(),
        binding: FavouriteDealsBinding()),
    GetPage(
        name: AppRoutes.aboutDonna,
        page: () => AboutScreen(),
        binding: AboutBinding()),
    GetPage(
        name: AppRoutes.splashScreen,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.myAccount,
        page: () => const MyAccount(),
        binding: MyAccountBindings()),
    GetPage(
        name: AppRoutes.notification,
        page: () => const NotificationScreen(),
        binding: NotificationBindings()),
    GetPage(
        name: AppRoutes.brands,
        page: () => const BrandsScreen(),
        binding: BrandsBinding()),
    GetPage(
        name: AppRoutes.categoryDetailsList,
        page: () => const CategoryListDetails(),
        binding: CategoryDetailsListBinding()),
    GetPage(
        name: AppRoutes.categoryItemDetail,
        page: () => CategoryItemDetail(),
        binding: CategoryItemDetailBinding()),
    GetPage(
        name: AppRoutes.accountDetails,
        page: () => const AccountDetails(),
        binding: AccountDetailsBindings()),
    GetPage(
        name: AppRoutes.staticPages,
        page: () => const StaticPagesScreen(),
        binding: StaticPagesBindings()),
    GetPage(
        name: AppRoutes.sortPages,
        page: () => Sort(),
        binding: SortBindings())
  ];
}
