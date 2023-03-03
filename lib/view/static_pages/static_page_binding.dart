import 'package:get/get.dart';
import 'package:humble_warrior/view/static_pages/static_page_controller.dart';

class StaticPagesBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => StaticPagesController());
  }
}