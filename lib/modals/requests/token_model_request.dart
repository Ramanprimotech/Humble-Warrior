class TokenRequestModel {
  // String? username;
  // String? password;
  String? userid;

  TokenRequestModel({/*this.username, this.password*/ this.userid});

  TokenRequestModel.fromJson(Map<String, dynamic> json) {
    // username = json['username'];
    // password = json['password'];
    userid = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['username'] = this.username;
    // data['password'] = this.password;
    data['user_id'] = this.userid;
    return data;
  }
}
