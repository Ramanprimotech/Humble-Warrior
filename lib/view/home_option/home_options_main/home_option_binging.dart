import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/view/sorting/sort_controller.dart';

import 'home_option_controller.dart';

class HomeOptionBindings implements Bindings {
  RouteSettings settings;
  HomeOptionBindings({required this.settings});
  @override
  void dependencies() {
    final args = settings.arguments;
    Get.put(SortController());
    if (args is Map<String, int>) {
      Get.put(HomeOptionController(initialIndex: args['id']??0));
    }else{
      Get.put(HomeOptionController(initialIndex: 0));
    }
  }
}
