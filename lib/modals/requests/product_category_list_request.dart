class ProductCategoriesListRequest {
  String? categoryId;
  String? page;

  ProductCategoriesListRequest({this.categoryId, this.page});

  ProductCategoriesListRequest.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['page'] = page;
    return data;
  }
}
