import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/category_item_detail/category_item_detail_controller.dart';

class CategoryItemDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryItemDetailController());
  }
}