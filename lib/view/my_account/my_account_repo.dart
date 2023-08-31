import '../../network/api_manager.dart';
import '../../network/endpoints.dart';
import '../../utils/app_strings.dart';
import '../../utils/shared_preference/shared_pref.dart';

class MyAccountRepo {

  Future<bool> notificationStatus() async{
    return await SharePreferenceData.getBoolValuesSF("notificationCheck") ?? true;
  }

  Future<String?> updateNotification({required bool status}) async {
    try {
      final id = await SharePreferenceData.getStringValuesSF(spRegisterUserId) ?? "-1";
      final payload = NotificationStatus(
        uId: int.parse(id),
        status: status
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

class NotificationStatus {
  final int uId;
  final bool status;

  const NotificationStatus({
    required this.uId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': uId,
      'notify': status,
    };
  }

  factory NotificationStatus.fromJson(Map<String, dynamic> json) {
    return NotificationStatus(
      uId: json['user_id'],
      status: json['notify'],
    );
  }
}
