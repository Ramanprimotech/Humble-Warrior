// ignore_for_file: unnecessary_new

import 'package:hive_flutter/hive_flutter.dart';

part 'product_details_response.g.dart';

/// id : "Unique ID"
/// item_name : "Name of the item"
/// cat_name : "Item category"
/// url : "Image Url"
/// shop_url : "Shop Url"
/// coupon_code : "Coupon Code"
/// product_description : "Detailsd pf the product"
/// ribbon_name: "Men's Products",
/// ribbon_color: "#00addd"
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
  @HiveField(7)
  String? ribbonName;
  @HiveField(8)
  String? ribbonColor;
  @HiveField(9)
  String? linkUrl;
  ProductDetailsResponse(
      {this.id,
      this.itemName,
      this.catName,
      this.url,
      this.shopUrl,
      this.couponCode,
      this.ribbonName,
      this.ribbonColor,
      this.linkUrl,
      this.productDescription});

  @override
  String toString() {
    return 'ProductDetailsResponse{id: $id, itemName: $itemName, catName: $catName, url: $url, shopUrl: $shopUrl, couponCode: $couponCode, productDescription: $productDescription, linkUrl: $linkUrl, ribbonName: $ribbonName, ribbonColor: $ribbonColor}';
  }

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    catName = json['cat_name'];
    catName = json['category_name'];
    url = json['url'];
    shopUrl = json['shop_url'];
    couponCode = json['coupon_code'];
    productDescription = json['product_description'];
    ribbonName = json['ribbon_name'];
    ribbonColor = json['ribbon_color'];
    linkUrl = json['link_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_name'] = itemName;
    data['cat_name'] = catName;
    data['category_name'] = catName;
    data['url'] = url;
    data['shop_url'] = shopUrl;
    data['coupon_code'] = couponCode;
    data['product_description'] = productDescription;
    data['ribbon_name'] = ribbonName;
    data['ribbon_color'] = ribbonColor;
    data['link_url'] = linkUrl;
    return data;
  }
}
