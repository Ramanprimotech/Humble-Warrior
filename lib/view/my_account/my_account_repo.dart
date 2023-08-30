import '../../network/api_manager.dart';
import '../../network/endpoints.dart';
import '../../utils/app_strings.dart';
import '../../utils/shared_preference/shared_pref.dart';

class MyAccountRepo {

  Future<bool> notificationStatus() async{
    return SharePreferenceData.getBoolValuesSF("notificationCheck") ?? false;
  }

  Future<String?> updateNotification({required bool status}) async {
    try {
      final payload = NotificationStatus(
        uId: await SharePreferenceData.getStringValuesSF(userId) ?? "",
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
  final String uId;
  final bool status;

  const NotificationStatus({
    required this.uId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'status': status,
    };
  }

  factory NotificationStatus.fromJson(Map<String, dynamic> json) {
    return NotificationStatus(
      uId: json['uId'],
      status: json['status'],
    );
  }
}
