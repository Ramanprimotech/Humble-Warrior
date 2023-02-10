class FrontPageResponseModel {
  bool? status;
  List<FrontPageDetails>? data;
  String? message;

  FrontPageResponseModel({this.status, this.data, this.message});

  FrontPageResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <FrontPageDetails>[];
      json['data'].forEach((v) {
        data!.add(FrontPageDetails.fromJson(v));
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

class FrontPageDetails {
  String? productName;
  String? url;

  FrontPageDetails({this.productName, this.url});

  FrontPageDetails.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['url'] = url;
    return data;
  }
}
