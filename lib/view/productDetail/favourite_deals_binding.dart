import 'package:get/get.dart';
import 'package:humble_warrior/view/productDetail/daily_deal_product_controller.dart';
import 'package:humble_warrior/view/productDetail/favourite_deals_controller.dart';

class FavouriteDealsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouriteDealController());
  }
}