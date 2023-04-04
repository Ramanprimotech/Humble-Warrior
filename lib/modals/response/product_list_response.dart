import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';

/// status : true
/// total_records : "16129"
/// data : [{"id":40390,"item_name":"","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amzn/lShI","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/323099986_891494395313729_583427410103322693_n.jpg"},{"id":40388,"item_name":"Michael Kors Savings!","cat_name":"Donna Daily Deals","shop_url":"https://shopstyle.it/l/bRKsb","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/Screen-Shot-2023-01-23-at-12.43.58-PM.png"},{"id":40386,"item_name":"Coleman Savings!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/0niT","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/Screen-Shot-2023-01-23-at-12.26.25-PM.png"},{"id":40384,"item_name":"BALEINE Heavy Duty Bag savings!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/0K3t","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/bags.jpg"},{"id":40382,"item_name":"Warm & Cozy Savings!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/WNF_","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/326270867_487406106802382_911480403234419031_n.jpg"},{"id":40380,"item_name":"Style Savings!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/xk07","coupon_code":"845WDK2L","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/325285422_4636465753145256_3385998517057852712_n.jpg"},{"id":40378,"item_name":"Storage Bag Organizers!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/w4q6","coupon_code":"509ZUF43","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/www.humblewarrior.com_.-20.jpg"},{"id":40376,"item_name":"Savings + Digital Q!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/AOv6","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/www.humblewarrior.com_.-19.jpg"},{"id":40374,"item_name":"Shacket Savings!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/MGV8","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/61T2a54P-xL._AC_UY741_.jpg"},{"id":40372,"item_name":"Loungewear Savings!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/8wSf","coupon_code":"40MGE349","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/71hXo7PD-YL._AC_UX569_.jpg"},{"id":40370,"item_name":"Today Only at Yankee Candle!!","cat_name":"Donna Daily Deals","shop_url":"https://shopstyle.it/l/bRJ07","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/50-OFF-SITEWIDE.jpg"},{"id":40368,"item_name":"Love Day Garden Flags!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/ra9Z","coupon_code":"60SL4SLF","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/www.humblewarrior.com-26.jpg"},{"id":40366,"item_name":"SNOW MUCH FUN!!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/14G5","coupon_code":"506U3FXM","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/326764875_1835875436780287_6442524984313747212_n.jpg"},{"id":40364,"item_name":"Lightning deal as of post time!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/s0g9","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/www.humblewarrior.com_.-14.jpg"},{"id":40362,"item_name":"Lightning deal as of post time!","cat_name":"Donna Daily Deals","shop_url":"https://shop.humblewarrior.com/amazon/aTbM","coupon_code":"","url":"http://112.196.54.37/Development/HW/wp-content/uploads/2023/01/www.humblewarrior.com_.-12.jpg"}]
/// message : "Success"

class ProductListResponse {
  bool? status;
  String? totalRecords;
  List<ProductDetailsResponse>? data;
  String? message;

  ProductListResponse(
      {this.status, this.totalRecords, this.data, this.message});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = "${json['total_records']}";
    if (json['data'] != null) {
      data = <ProductDetailsResponse>[];
      json['data'].forEach((v) {
        data!.add(ProductDetailsResponse.fromJson(v));
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
