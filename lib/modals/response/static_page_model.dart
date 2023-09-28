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
        data!.add(StaticData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class StaticData {
  String? pageTitle;
  String? pageContent;
  String? page_bottom_image;
  String? page_less_content;
  dynamic pageImage;

  StaticData({this.pageTitle, this.pageContent, this.pageImage});

  StaticData.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    pageContent = json['page_content'];
    pageContent = json['page_content'];
    page_bottom_image = json['page_bottom_image'];
    page_less_content = json['page_less_content'];
    pageImage = json['page_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page_title'] = pageTitle;
    data['page_content'] = pageContent;
    data['page_image'] = pageImage;
    data['page_bottom_image'] = page_bottom_image;
    data['page_less_content'] = page_less_content;
    return data;
  }
}
