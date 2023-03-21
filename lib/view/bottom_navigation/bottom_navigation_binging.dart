import 'package:humble_warrior/hw.dart';

class BottomNavigationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
    Get.put(ThemeController(), permanent: true);
    Get.put(HomeScreenController());
    Get.put(BottomNavigationController(), permanent: true);
    Get.put(FrontPageDetailController());
    Get.put(MyAccountController());
    Get.put(WishListController());
  }
}
