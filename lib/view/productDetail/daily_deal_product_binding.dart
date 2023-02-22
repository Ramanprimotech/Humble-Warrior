import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/daily_deal_product_controller.dart';

class DailyDealProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyDealProductController());
  }
}