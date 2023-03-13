import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/abstract_enums/donna_options.dart';

class WishListController extends GetxController {
  bool value = false;
  RxList data = [].obs;

  HiveService _hiveService = Get.find();
  Future<void> getLoggedValue() async {
    value = await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
  }

  getWishList() {
    data.value.clear();
    data.value = _hiveService.getWishList().toList();
  }

  @override
  void onInit() {
    getLoggedValue();
    getWishList();
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
