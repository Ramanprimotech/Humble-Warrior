import 'package:get/get.dart';
import 'home_option_controller.dart';

class HomeOptionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeOptionController());
  }
}
