class AuthDataRequest {
  String? token;
  String? os;
  String? userId;

  AuthDataRequest({this.token, this.os, this.userId});

  AuthDataRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    os = json['os'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['os'] = this.os;
    data['user_id'] = this.userId;
    return data;
  }

  @override
  String toString() {
    return 'AuthDataRequest{token: $token, os: $os, userId: $userId}';
  }
}
