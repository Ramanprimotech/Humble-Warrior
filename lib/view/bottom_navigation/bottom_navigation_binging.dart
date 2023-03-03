import 'package:get/get.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_controller.dart';
import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';

import '../../hive/hive_storage_service.dart';
import '../../utils/app_themes/app_theme_controller.dart';
import '../home/home_controller.dart';
import '../my_account/my_account_controller.dart';
import '../productDetail/front_page_details_screen/front_page_detail_controller.dart';

class BottomNavigationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(HiveService());
    Get.put(HomeScreenController());
    Get.put(BottomNavigationController());
    Get.put(FrontPageDetailController());
    Get.put(MyAccountController());
    Get.put(WishListController());
  }
}
