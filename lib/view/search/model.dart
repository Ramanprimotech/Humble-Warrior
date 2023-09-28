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
        data!.add(SearchPosts.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? categoryName;

  SearchPosts(
      {this.id, this.itemName, this.postType, this.url, this.categoryName});

  SearchPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    postType = json['post_type'];
    url = json['url'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['post_type'] = this.postType;
    data['url'] = this.url;
    data['category_name'] = this.categoryName;
    return data;
  }
}
