/*class VersionResponse {
  bool? success;
  String? message;
  String? version;

  VersionResponse({this.success, this.message, this.version});

  @override
  String toString() {
    return 'VersionResponse{success: $success, message: $message, version: $version}';
  }

  VersionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['version'] = this.version;
    return data;
  }
}*/

class VersionResponse {
  bool? success;
  String? message;
  String? androidLink;
  String? iosLink;
  String? version;


  VersionResponse({this.success, this.message,  this.androidLink, this.iosLink, this.version});

  @override
  String toString() {
    return 'VersionResponse{success: $success, message: $message, android_link: $androidLink, ios_link: $iosLink, version: $version}';
  }

  VersionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    androidLink = json['android_link'];
    iosLink = json['ios_link'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['android_link'] = this.androidLink;
    data['ios_link'] = this.iosLink;
    data['version'] = this.version;
    return data;
  }
}

