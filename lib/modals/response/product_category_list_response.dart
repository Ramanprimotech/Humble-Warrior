class ProductCategoriesListResponse {
  bool? status;
  List<Data>? data;
  String? message;

  ProductCategoriesListResponse({this.status, this.data, this.message});

  ProductCategoriesListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? productName;
  String? url;
  Null? ribbonName;
  String? productDescription;
  Null? ribbonColor;

  Data(
      {this.productName,
      this.url,
      this.ribbonName,
      this.productDescription,
      this.ribbonColor});

  Data.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    url = json['url'];
    ribbonName = json['ribbon_name'];
    productDescription = json['product_description'];
    ribbonColor = json['ribbon_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['url'] = this.url;
    data['ribbon_name'] = this.ribbonName;
    data['product_description'] = this.productDescription;
    data['ribbon_color'] = this.ribbonColor;
    return data;
  }
}
