import 'package:hive_flutter/hive_flutter.dart';

part 'product_details_response.g.dart';

/// id : 39686
/// item_name : "Top 100 Beauty Must Haves!"
/// cat_name : "Favourite Things"
/// url : "http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/326170111_716398506788518_1626924494559068665_n.jpg"
/// shop_url : "https://shop.humblewarrior.com/amzn/lShI"
/// coupon_code : ""
/// product_description : ""
@HiveType(typeId: 1)
class ProductDetailsResponse {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? itemName;
  @HiveField(2)
  String? catName;
  @HiveField(3)
  String? url;
  @HiveField(4)
  String? shopUrl;
  @HiveField(5)
  String? couponCode;
  @HiveField(6)
  String? productDescription;
  ProductDetailsResponse(
      {this.id,
      this.itemName,
      this.catName,
      this.url,
      this.shopUrl,
      this.couponCode,
      this.productDescription});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    catName = json['cat_name'];
    url = json['url'];
    shopUrl = json['shop_url'];
    couponCode = json['coupon_code'];
    productDescription = json['product_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['cat_name'] = this.catName;
    data['url'] = this.url;
    data['shop_url'] = this.shopUrl;
    data['coupon_code'] = this.couponCode;
    data['product_description'] = this.productDescription;
    return data;
  }
}
