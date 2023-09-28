class ProductCategoriesResponse {
  bool? status;
  List<ProductCategoryItem>? data;
  String? message;

  ProductCategoriesResponse({this.status, this.data, this.message});

  ProductCategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductCategoryItem>[];
      json['data'].forEach((v) {
        data!.add(ProductCategoryItem.fromJson(v));
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

class ProductCategoryItem {
  String? categoryName;
  String? categoryImage;
  int? id;

  ProductCategoryItem({this.categoryName, this.categoryImage, this.id});

  ProductCategoryItem.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'ProductCategoryItem{categoryName: $categoryName, categoryImage: $categoryImage, id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategoryItem &&
          runtimeType == other.runtimeType &&
          categoryName == other.categoryName &&
          categoryImage == other.categoryImage &&
          id == other.id;

  @override
  int get hashCode =>
      categoryName.hashCode ^ categoryImage.hashCode ^ id.hashCode;
}
