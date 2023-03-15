import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/response/notification_response_model.dart';
import 'package:humble_warrior/network/api_call.dart';

class NotificationController extends GetxController {
  Future<NotificationResponseModel> notificationList() async {
    /// User Firebase Token
    String? tokenFirebase = await FirebaseMessaging.instance.getToken();

    /// User_id
    String? userId =
        await SharePreferenceData.getStringValuesSF(spRegisterUserId);

    ///Platform
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
    // NotificationRequestModel payload = NotificationRequestModel(
    //     token: tokenFirebase, userId: userId, device: platform);
    NotificationResponseModel notificationResponseModel =
        await CallAPI.notificationListAPI(payload: payload);
    return notificationResponseModel;
  }
}
