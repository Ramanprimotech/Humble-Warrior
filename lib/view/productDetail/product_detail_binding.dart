import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}
