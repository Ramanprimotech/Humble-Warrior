import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';

/// status : true
/// data : [{"product_name":"The Classic Coatigan","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/Angashion-coat-cardigan-01-12-23-LIVE-PIC-SMFT.jpg","ribbon_name":null,"product_description":"","ribbon_color":null}]
/// message : "Success"

class ProductDetailsApiResponse {
  ProductDetailsApiResponse({
    this.status,
    this.data,
    this.message,
  });

  ProductDetailsApiResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductDetailsResponse.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? status;
  List<ProductDetailsResponse>? data;
  String? message;
  ProductDetailsApiResponse copyWith({
    bool? status,
    List<ProductDetailsResponse>? data,
    String? message,
  }) =>
      ProductDetailsApiResponse(
        status: status ?? this.status,
        data: data ?? this.data,
        message: message ?? this.message,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}
