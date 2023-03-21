import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

import 'daily_deal_product_controller.dart';

class DailyDealProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
    Get.lazyPut(() => DailyDealProductController());
  }
}
