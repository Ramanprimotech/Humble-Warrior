class AuthDataRequest {
  String? token;
  String? os;
  String? userId;
  String? email;

  AuthDataRequest({this.token, this.os, this.userId, this.email});

  AuthDataRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    os = json['os'];
    userId = json['user_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token!.trim();
    data['os'] = this.os!.trim();
    data['user_id'] = this.userId!.trim();
    data['email'] = this.email!.trim();
    return data;
  }

  @override
  String toString() {
    return 'AuthDataRequest{\ntoken:$token,\nos:$os,\nuserId:$userId,\nemail:$email\n}';
  }
}
