import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

import 'favourite_deals_controller.dart';

class FavouriteDealsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouriteDealController());
    Get.lazyPut(() => ProductDetailController());
  }
}
