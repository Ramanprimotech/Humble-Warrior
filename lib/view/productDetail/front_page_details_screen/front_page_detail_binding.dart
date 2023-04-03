import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';
import 'package:humble_warrior/hw.dart';

class FrontPageDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FrontPageDetailController());
    Get.lazyPut(() => ProductDetailController());
  }
}
