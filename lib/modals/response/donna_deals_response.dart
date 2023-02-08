class DonnaDealsResponseModal {
  bool? status;
  List<DonnaDealsList>? data;
  String? message;

  DonnaDealsResponseModal({this.status, this.data, this.message});

  DonnaDealsResponseModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DonnaDealsList>[];
      json['data'].forEach((v) {
        data!.add(new DonnaDealsList.fromJson(v));
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

class DonnaDealsList {
  String? dealName;
  String? shopUrl;
  String? couponCode;
  String? url;

  DonnaDealsList({this.dealName, this.shopUrl, this.couponCode, this.url});

  DonnaDealsList.fromJson(Map<String, dynamic> json) {
    dealName = json['deal_name'];
    shopUrl = json['shop_url'];
    couponCode = json['coupon_code'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_name'] = this.dealName;
    data['shop_url'] = this.shopUrl;
    data['coupon_code'] = this.couponCode;
    data['url'] = this.url;
    return data;
  }
}
