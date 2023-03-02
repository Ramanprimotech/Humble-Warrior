import 'package:get/get.dart';
import 'package:humble_warrior/modals/abstract_enums/donna_options.dart';
import 'package:humble_warrior/utils/shared_prefrence/shared_pref.dart';

import '../../utils/app_strings.dart';
import '../../utils/routes/app_routes.dart';

class WishListController extends GetxController {
  bool value = false;

  Future<void> getLoggedValue() async {
    value = await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
  }

  @override
  void onInit() {
    getLoggedValue();
    super.onInit();
  }
}

class WishListRouting extends DonnaOptions {
  final dynamic details;
  WishListRouting({this.details});
  @override
  donnaDeals() {
    Get.toNamed(AppRoutes.dailyDealProductDetail, arguments: [details]);
  }

  @override
  donnaFavourite() {
    Get.toNamed(AppRoutes.favouriteDeal, arguments: [details]);
  }

  @override
  frontPage() {
    Get.toNamed(AppRoutes.frontPageProductDetail, arguments: [details]);
  }
}
