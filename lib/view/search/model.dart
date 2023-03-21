// class ItemDetails {
//   bool? status;
//   String? totalRecords;
//   List<Godds>? data;
//   String? message;
//
//   ItemDetails({this.status, this.totalRecords, this.data, this.message});
//
//   ItemDetails.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     totalRecords = json['total_records'];
//     if (json['data'] != null) {
//       data = <Godds>[];
//       json['data'].forEach((v) {
//         data!.add(new Godds.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['total_records'] = this.totalRecords;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Godds {
//   int? id;
//   String? itemName;
//   String? catName;
//   String? url;
//
//   Godds({this.id, this.itemName, this.catName, this.url});
//
//   Godds.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     itemName = json['item_name'];
//     catName = json['cat_name'];
//     url = json['url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['item_name'] = this.itemName;
//     data['cat_name'] = this.catName;
//     data['url'] = this.url;
//     return data;
//   }
// }
//
// class SingleProductDetailsResponse {
//   bool? status;
//   List<ProDetailItem>? data;
//   String? message;
//
//   SingleProductDetailsResponse({this.status, this.data, this.message});
//
//   SingleProductDetailsResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <ProDetailItem>[];
//       json['data'].forEach((v) {
//         data!.add(new ProDetailItem.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class ProDetailItem {
//   String? productName;
//   dynamic? url;
//   String? ribbonName;
//   String? productDescription;
//   String? ribbonColor;
//
//   ProDetailItem(
//       {this.productName,
//       this.url,
//       this.ribbonName,
//       this.productDescription,
//       this.ribbonColor});
//
//   ProDetailItem.fromJson(Map<String, dynamic> json) {
//     productName = json['product_name'];
//     url = json['url'];
//     ribbonName = json['ribbon_name'];
//     productDescription = json['product_description'];
//     ribbonColor = json['ribbon_color'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['product_name'] = this.productName;
//     data['url'] = this.url;
//     data['ribbon_name'] = this.ribbonName;
//     data['product_description'] = this.productDescription;
//     data['ribbon_color'] = this.ribbonColor;
//     return data;
//   }
// }
class SearchResponseModel {
  bool? status;
  int? totalRecords;
  List<SearchPosts>? data;
  String? message;

  SearchResponseModel(
      {this.status, this.totalRecords, this.data, this.message});

  SearchResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    if (json['data'] != null) {
      data = <SearchPosts>[];
      json['data'].forEach((v) {
        data!.add(new SearchPosts.fromJson(v));
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

class SearchPosts {
  int? id;
  String? itemName;
  String? postType;
  String? url;

  SearchPosts({this.id, this.itemName, this.postType, this.url});

  SearchPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    postType = json['post_type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['post_type'] = this.postType;
    data['url'] = this.url;
    return data;
  }
}
