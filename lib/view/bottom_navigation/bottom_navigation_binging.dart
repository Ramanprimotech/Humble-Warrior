import 'package:get/get.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_controller.dart';
import 'package:humble_warrior/view/home/home_controller.dart';
import 'package:humble_warrior/view/productDetail/product_detail_Screen.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

import '../my_account/my_account_controller.dart';

class BottomNavigationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationController());
    Get.put(HomeScreenController());
    Get.put(ProductDetailController());
    Get.put(MyAccountController());

  }
}
