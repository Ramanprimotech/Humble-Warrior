class HomeCategoryResponseModel {
  bool? status;
  List<HomeCategoryList>? data;
  String? message;

  HomeCategoryResponseModel({this.status, this.data, this.message});

  HomeCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <HomeCategoryList>[];
      json['data'].forEach((v) {
        data!.add(HomeCategoryList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class HomeCategoryList {
  String? categoryName;
  String? categoryImage;
  int? id;

  @override
  String toString() {
    return 'HomeCategoryList{categoryName: $categoryName, categoryImage: $categoryImage, id: $id}';
  }

  HomeCategoryList({this.categoryName, this.categoryImage, this.id});

  HomeCategoryList.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['id'] = id;
    return data;
  }
}
