class AuthDataRequest {
  String? token;
  String? os;
  String? userId;
  String? email;

  AuthDataRequest({this.token, this.userId, this.email, this.os});

  AuthDataRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    os = json['os'];
    userId = json['user_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['os'] = this.os;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    return data;
  }

  @override
  String toString() {
    return 'AuthDataRequest{token: $token, os: $os, userId: $userId, email: $email}';
  }
}
