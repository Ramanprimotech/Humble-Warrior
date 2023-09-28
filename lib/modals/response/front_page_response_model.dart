class FrontPageResponseModel {
  bool? status;
  String? totalRecords;
  List<FrontPageDetails>? data;
  String? message;

  FrontPageResponseModel(
      {this.status, this.totalRecords, this.data, this.message});

  FrontPageResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
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
    data['total_records'] = totalRecords;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['url'] = url;
    data['ribbon_name'] = ribbonName;
    data['ribbon_color'] = ribbonColor;
    return data;
  }
}
