
class StaticPagesResponse {
  bool? status;
  List<StaticData>? data;
  String? message;

  StaticPagesResponse({this.status, this.data, this.message});

  StaticPagesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StaticData>[];
      json['data'].forEach((v) {
        data!.add(new StaticData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class StaticData {
  String? pageTitle;
  String? pageContent;
  dynamic pageImage;

  StaticData({this.pageTitle, this.pageContent, this.pageImage});

  StaticData.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    pageContent = json['page_content'];
    pageImage = json['page_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_title'] = this.pageTitle;
    data['page_content'] = this.pageContent;
    data['page_image'] = this.pageImage;
    return data;
  }
}







/*class StaticPagesResponse {
  bool? status;
  List<StaticData>? data;
  String? message;

  StaticPagesResponse({this.status, this.data, this.message});

  StaticPagesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StaticData>[];
      json['data'].forEach((v) {
        data!.add(new StaticData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class StaticData {
  String? pageTitle;
  String? pageContent;
  bool? pageImage;

  StaticData({this.pageTitle, this.pageContent, this.pageImage});

  StaticData.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    pageContent = json['page_content'];
    pageImage = json['page_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_title'] = this.pageTitle;
    data['page_content'] = this.pageContent;
    data['page_image'] = this.pageImage;
    return data;
  }
}*/
