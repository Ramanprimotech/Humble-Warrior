import 'package:get/get.dart';
import 'package:humble_warrior/view/brands/brands_controller.dart';

class BrandsBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BrandsController());
  }
}