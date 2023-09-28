// ignore_for_file: unnecessary_this

class NotificationRequestModel {
  String? token;
  String? device;
  String? userId;

  @override
  String toString() {
    return 'NotificationRequestModel{token: $token, device: $device, userId: $userId}';
  }

  NotificationRequestModel({this.token, this.device, this.userId});

  NotificationRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    device = json['device'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = this.token;
    data['device'] = this.device;
    data['user_id'] = this.userId;
    return data;
  }
}
