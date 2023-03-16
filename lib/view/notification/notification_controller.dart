import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/response/notification_response_model.dart';
import 'package:humble_warrior/network/api_call.dart';

class NotificationController extends GetxController {
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
    NotificationResponseModel notificationResponseModel =
        await CallAPI.notificationListAPI(payload: payload);
    return notificationResponseModel;
  }

  /// Notification Status API
  Future<bool> notificationStatus(String id) async {
    String? tokenFirebase = await FirebaseMessaging.instance.getToken();

    String? platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "iOS";
    }

    var payload = {"token": tokenFirebase, "id": id, "device": platform};

    bool status = await CallAPI.notificationStatusAPI(payload: payload);
    return status;
  }
}
