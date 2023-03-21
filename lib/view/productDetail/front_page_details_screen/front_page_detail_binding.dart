import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/front_page_details_screen/front_page_detail_controller.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

class FrontPageDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FrontPageDetailController());
    Get.lazyPut(() => ProductDetailController());
  }
}
