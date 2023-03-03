class DonnaFavouriteResponseModel {
  bool? status;
  String? totalRecords;
  List<DonnaFavouriteDetails>? data;
  String? message;

  DonnaFavouriteResponseModel(
      {this.status, this.totalRecords, this.data, this.message});

  DonnaFavouriteResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    if (json['data'] != null) {
      data = <DonnaFavouriteDetails>[];
      json['data'].forEach((v) {
        data!.add(DonnaFavouriteDetails.fromJson(v));
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

class DonnaFavouriteDetails {
  String? productName;
  String? url;

  DonnaFavouriteDetails({this.productName, this.url});

  DonnaFavouriteDetails.fromJson(Map<String, dynamic> json) {
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
