class DonnaDealsResponseModal {
  bool? status;
  List<DonnaDealsDetails>? data;
  String? totalRecords;
  String? message;

  DonnaDealsResponseModal(
      {this.status, this.totalRecords, this.data, this.message});

  DonnaDealsResponseModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    if (json['data'] != null) {
      data = <DonnaDealsDetails>[];
      json['data'].forEach((v) {
        data!.add(DonnaDealsDetails.fromJson(v));
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

class DonnaDealsDetails {
  String? dealName;
  String? shopUrl;
  String? couponCode;
  String? url;

  DonnaDealsDetails({this.dealName, this.shopUrl, this.couponCode, this.url});

  DonnaDealsDetails.fromJson(Map<String, dynamic> json) {
    dealName = json['deal_name'];
    shopUrl = json['shop_url'];
    couponCode = json['coupon_code'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deal_name'] = dealName;
    data['shop_url'] = shopUrl;
    data['coupon_code'] = couponCode;
    data['url'] = url;
    return data;
  }
}
