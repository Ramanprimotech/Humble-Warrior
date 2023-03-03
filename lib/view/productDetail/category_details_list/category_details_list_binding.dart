import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/category_details_list/category_details_list_controller.dart';

class CategoryDetailsListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailsListController());
  }
}