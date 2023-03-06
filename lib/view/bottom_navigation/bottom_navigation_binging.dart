import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';

import '../../hive/hive_storage_service.dart';

import 'package:humble_warrior/hw.dart';

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
