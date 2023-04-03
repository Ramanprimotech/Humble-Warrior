import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/filter/filter_ui.dart';
import 'package:humble_warrior/view/my_account/account_details/account_details_binding.dart';
import 'package:humble_warrior/view/my_account/account_details/account_details_screen.dart';
import 'package:humble_warrior/view/productDetail/category_details_list/category_details_list_binding.dart';
import 'package:humble_warrior/view/productDetail/category_details_list/category_details_list_screen.dart';
import 'package:humble_warrior/view/productDetail/category_item_detail/category_item_detail_binding.dart';
import 'package:humble_warrior/view/productDetail/category_item_detail/category_item_detail_screen.dart';
import 'package:humble_warrior/view/search/search_binding.dart';
import 'package:humble_warrior/view/sorting/sort_binding.dart';
import 'package:humble_warrior/view/sorting/sort_screen.dart';
import 'package:humble_warrior/view/static_pages/static_page_binding.dart';
import 'package:humble_warrior/view/static_pages/static_page_screen.dart';

class AppPages {
  static String initialRoute = AppRoutes.splashScreen;
  static final BottomNavigationController _bottomNavigationController =
      Get.put(BottomNavigationController(), permanent: true);
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
        page: () {
          _bottomNavigationController.isNavigated = true;
          return  HomeOptionScreen();
        },
        binding: HomeOptionBindings()),
    GetPage(
        name: AppRoutes.dailyDealProductDetail,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return DailyDealProduct();
        },
        binding: DailyDealProductBinding()),
    GetPage(
        name: AppRoutes.frontPageProductDetail,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return FrontPageDetailScreen();
        },
        binding: FrontPageDetailBinding()),
    GetPage(
        name: AppRoutes.favouriteDeal,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const FavouriteDeals();
        },
        binding: FavouriteDealsBinding()),
    GetPage(
        name: AppRoutes.aboutDonna,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const AboutScreen();
        },
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
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const NotificationScreen();
        },
        binding: NotificationBindings()),
    GetPage(
        name: AppRoutes.brands,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const BrandsScreen();
        },
        binding: BrandsBinding()),
    GetPage(
        name: AppRoutes.categoryDetailsList,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const CategoryListDetails();
        },
        binding: CategoryDetailsListBinding()),
    GetPage(
        name: AppRoutes.categoryItemDetail,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return CategoryItemDetail();
        },
        binding: CategoryItemDetailBinding()),
    GetPage(
        name: AppRoutes.accountDetails,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const AccountDetails();
        },
        binding: AccountDetailsBindings()),
    GetPage(
        name: AppRoutes.staticPages,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const StaticPagesScreen();
        },
        binding: StaticPagesBindings()),
    GetPage(
        name: AppRoutes.sortPages,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const Sort();
        },
        binding: SortBindings()),
    GetPage(
        name: AppRoutes.searchView,
        page: () {
          _bottomNavigationController.isNavigated = true;
          return const SearchView();
        },
        binding: SearchViewBindings()),
    GetPage(
      name: AppRoutes.filterView,
      page: () {
        _bottomNavigationController.isNavigated = true;
        return FilterScreen();
      },
    )
  ];
}
