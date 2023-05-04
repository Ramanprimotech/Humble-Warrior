import 'package:humble_warrior/hw.dart';

class WishListController extends GetxController {
  RxBool loggedIn = true.obs;
  RxList data = [].obs;

  final HiveService _hiveService = Get.find();
  Future<void> getLoggedValue() async {
    loggedIn.value =
        await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
  }

  getWishList() {
    data.value.clear();
    data.value = _hiveService.getWishList().toList();
  }

  @override
  void onInit() async {
    await getLoggedValue();
    getWishList();
    super.onInit();
  }
}

class WishListRouting extends DonnaOptions {
  final dynamic details;
  WishListRouting({this.details});
  @override
  donnaDeals() {
    Get.toNamed(AppRoutes.categoryItemDetail,id: 2,
        arguments: {"route" : 2, "details" :   ProductDetailsResponse(
            id: details.id)});
  }

  @override
  donnaFavourite() {
    Get.toNamed(AppRoutes.categoryItemDetail,id: 2,
        arguments: {"route" : 2,"details" :   ProductDetailsResponse(
            id: details.id)});
  }

  @override
  frontPage() {
    Get.toNamed(AppRoutes.categoryItemDetail,id: 2,
        arguments: { "details" :   ProductDetailsResponse(
            id: details.id)});
  }
}
