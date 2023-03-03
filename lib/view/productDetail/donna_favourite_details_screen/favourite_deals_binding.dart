import 'package:get/get.dart';

import 'favourite_deals_controller.dart';

class FavouriteDealsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouriteDealController());
  }
}
