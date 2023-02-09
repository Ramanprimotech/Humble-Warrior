class BrandsResponseModel {
  bool? status;
  List<BrandDetails>? data;
  String? message;

  BrandsResponseModel({this.status, this.data, this.message});

  BrandsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BrandDetails>[];
      json['data'].forEach((v) {
        data!.add(new BrandDetails.fromJson(v));
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

class BrandDetails {
  String? brandName;
  String? brandImage;
  String? brandLink;

  BrandDetails({this.brandName, this.brandImage, this.brandLink});

  BrandDetails.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    brandImage = json['brand_image'];
    brandLink = json['brand_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['brand_image'] = this.brandImage;
    data['brand_link'] = this.brandLink;
    return data;
  }
}
