class AuthDataRequest {
  String? token;
  String? device;
  String userId = "";
  String email = "";

  AuthDataRequest(
      {this.token, required this.userId, required this.email, this.device});

  AuthDataRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    device = json['device'];
    userId = json['user_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['device'] = this.device;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    return data;
  }

  @override
  String toString() {
    return 'AuthDataRequest{token: $token, device: $device, userId: $userId, email: $email}';
  }
}
