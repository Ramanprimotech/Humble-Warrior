class DonnaFavouriteResponseModel {
  bool? status;
  List<DonnaFavouriteDetails>? data;
  String? message;

  DonnaFavouriteResponseModel({this.status, this.data, this.message});

  DonnaFavouriteResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DonnaFavouriteDetails>[];
      json['data'].forEach((v) {
        data!.add(new DonnaFavouriteDetails.fromJson(v));
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

class DonnaFavouriteDetails {
  String? productName;
  String? url;

  DonnaFavouriteDetails({this.productName, this.url});

  DonnaFavouriteDetails.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['url'] = this.url;
    return data;
  }
}