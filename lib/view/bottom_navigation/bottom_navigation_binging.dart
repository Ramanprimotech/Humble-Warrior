import 'package:humble_warrior/hw.dart';

class BottomNavigationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(HomeScreenController());
    Get.put(BottomNavigationController());
    Get.put(FrontPageDetailController());
    Get.put(MyAccountController());
    Get.put(WishListController());
  }
}
