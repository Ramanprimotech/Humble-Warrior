import 'package:get/get.dart';
import 'package:humble_warrior/view/home_option/home_option_controller.dart';

class HomeOptionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeOptionController());
  }
}
