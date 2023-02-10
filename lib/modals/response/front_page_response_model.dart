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
        data!.add(new FrontPageDetails.fromJson(v));
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

class FrontPageDetails {
  String? productName;
  String? url;
  String? ribbonName;
  String? ribbonColor;

  FrontPageDetails(
      {this.productName, this.url, this.ribbonName, this.ribbonColor});

  FrontPageDetails.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    url = json['url'];
    ribbonName = json['ribbon_name'];
    ribbonColor = json['ribbon_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['url'] = this.url;
    data['ribbon_name'] = this.ribbonName;
    data['ribbon_color'] = this.ribbonColor;
    return data;
  }
}
