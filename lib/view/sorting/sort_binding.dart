import 'package:get/get.dart';
import 'package:humble_warrior/view/sorting/sort_controller.dart';

class SortBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SortController());
  }
}