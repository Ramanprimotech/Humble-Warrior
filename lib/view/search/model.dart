class ItemDetails {
  bool? status;
  String? totalRecords;
  List<Godds>? data;
  String? message;

  ItemDetails({this.status, this.totalRecords, this.data, this.message});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    if (json['data'] != null) {
      data = <Godds>[];
      json['data'].forEach((v) {
        data!.add(new Godds.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total_records'] = this.totalRecords;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Godds {
  int? id;
  String? itemName;
  String? catName;
  String? url;

  Godds({this.id, this.itemName, this.catName, this.url});

  Godds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    catName = json['cat_name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['cat_name'] = this.catName;
    data['url'] = this.url;
    return data;
  }
}