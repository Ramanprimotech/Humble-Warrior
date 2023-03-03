import 'package:get/get.dart';

import 'daily_deal_product_controller.dart';

class DailyDealProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyDealProductController());
  }
}
