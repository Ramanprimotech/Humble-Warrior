import '../../network/api_manager.dart';
import '../../network/endpoints.dart';
import '../../utils/app_strings.dart';
import '../../utils/shared_preference/shared_pref.dart';

class MyAccountRepo {

  Future<bool> notificationStatus() async{
    try{
      final id = await SharePreferenceData.getStringValuesSF(spRegisterUserId) ?? "-1";

      final payload = GetNotificationData(
        uId: int.parse(id)
      );
      final response = await APIManager()
          .postAPICallNoBearer(
          url: Endpoints.get_notification_user,
          param: payload
      );

      if(response["status"] == true){
        final notify = response["notify"];
        await SharePreferenceData.addBoolToSF("notificationCheck", notify == "true");
      }
    // ignore: empty_catches
    }catch(e){}

    return await SharePreferenceData.getBoolValuesSF("notificationCheck") ?? true;
  }

  Future<String?> updateNotification({required bool status}) async {
    try {
      final id = await SharePreferenceData.getStringValuesSF(spRegisterUserId) ?? "-1";
      final payload = UpdateNotificationData(
        uId: int.parse(id),
        status: status.toString()
      );

      final response = await APIManager()
        .postAPICallNoBearer(
          url: Endpoints.update_notification_user,
          param: payload
      );

      if(response["status"] == true){
        SharePreferenceData.addBoolToSF("notificationCheck", status);
      }
      return response["message"];
    } catch (e) {
      return "Error: $e";
    }
  }
}

class GetNotificationData {
  final int uId;

  const GetNotificationData({
    required this.uId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': uId,
    };
  }

  factory GetNotificationData.fromJson(Map<String, dynamic> json) {
    return GetNotificationData(
      uId: json['user_id'],
    );
  }
}

class UpdateNotificationData {
  final int uId;
  final String status;

  const UpdateNotificationData({
    required this.uId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': uId,
      'notify': status,
    };
  }

  factory UpdateNotificationData.fromJson(Map<String, dynamic> json) {
    return UpdateNotificationData(
      uId: json['user_id'],
      status: json['notify'],
    );
  }
}
