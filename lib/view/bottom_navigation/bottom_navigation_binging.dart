import 'package:get/get.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_controller.dart';
import 'package:humble_warrior/view/home/home_controllerrt';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';
import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';

import '../my_account/my_account_controller.dart';

class BottomNavigationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(HomeScreenController());
    Get.put(BottomNavigationController());
    Get.put(ProductDetailController());
    Get.put(MyAccountController());
    Get.put(WishListController());
  }
}
