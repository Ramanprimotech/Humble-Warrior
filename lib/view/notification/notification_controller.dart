import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/modals/response/notification_response_model.dart';
import 'package:humble_warrior/network/api_call.dart';

class NotificationController extends GetxController {
  RxBool loggedIn = true.obs;

  @override
  void onInit() async {
    await getLoggedValue();
    super.onInit();
  }

  /// Notification List API
  Future<NotificationResponseModel> notificationList() async {
    String? tokenFirebase = await FirebaseMessaging.instance.getToken();

    String? userId =
        await SharePreferenceData.getStringValuesSF(spRegisterUserId);

    String? platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "iOS";
    }

    var payload = {
      "token": tokenFirebase,
      "user_id": userId,
      "device": platform
    };
    if (userId != null) {
      NotificationResponseModel notificationResponseModel =
          await CallAPI.notificationListAPI(payload: payload);
      return notificationResponseModel;
    } else {
      return NotificationResponseModel(posts: []);
    }
  }

  /// Notification Status API
  Future<bool> notificationStatus(int? id) async {
    String? tokenFirebase = await FirebaseMessaging.instance.getToken();

    String? platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "iOS";
    }

    var payload = {
      "token": tokenFirebase,
      "id": id.toString(),
      "device": platform,
      "viewed": "1"
    };

    bool status = await CallAPI.notificationStatusAPI(payload: payload);
    return status;
  }

  Future<void> getLoggedValue() async {
    loggedIn.value =
        await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
    print("LoggedIN-------- $loggedIn.value");
  }

  Future<bool> notificationDetailsNavigator(String? cat, int? id) async {
    "$cat    $id".log();
    String category = cat.toString().toUpperCase();
    ProductDetailsResponse productDetailsResponse =
        ProductDetailsResponse(id: id);
    if (category == "Favourite Things".toUpperCase()) {
      Get.toNamed(AppRoutes.favouriteDeal, arguments: [productDetailsResponse]);
    } else if (category == "Front Page Deals".toUpperCase()) {
      Get.toNamed(AppRoutes.frontPageProductDetail,
          arguments: [productDetailsResponse]);
    } else if (category == "Donna Daily Deals".toUpperCase()) {
      Get.toNamed(AppRoutes.dailyDealProductDetail,
          arguments: [productDetailsResponse]);
    } else {
      Get.toNamed(AppRoutes.dailyDealProductDetail,
          arguments: [productDetailsResponse]);
    }
    return await notificationStatus(id);
  }
}
