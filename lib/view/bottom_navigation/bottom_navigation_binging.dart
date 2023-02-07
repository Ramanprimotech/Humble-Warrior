import 'package:get/get.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_controller.dart';
import 'package:humble_warrior/view/home/home_controller.dart';

class BottomNavigationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationController());
    Get.put(HomeScreenController());
  }
}
