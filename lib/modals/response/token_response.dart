class TokenResponseModel {
  String? token;
  String? userEmail;
  String? userNicename;
  String? userDisplayName;

  @override
  String toString() {
    return 'TokenResponseModel{token: $token, userEmail: $userEmail, userNicename: $userNicename, userDisplayName: $userDisplayName}';
  }

  TokenResponseModel(
      {this.token, this.userEmail, this.userNicename, this.userDisplayName});

  TokenResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userEmail = json['user_email'];
    userNicename = json['user_nicename'];
    userDisplayName = json['user_display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['user_email'] = userEmail;
    data['user_nicename'] = userNicename;
    data['user_display_name'] = userDisplayName;
    return data;
  }
}
