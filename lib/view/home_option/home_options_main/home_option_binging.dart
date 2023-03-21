import 'package:get/get.dart';
import 'package:humble_warrior/view/sorting/sort_controller.dart';

import 'home_option_controller.dart';

class HomeOptionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SortController());
    Get.put(HomeOptionController());
  }
}
