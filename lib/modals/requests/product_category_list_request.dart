class ProductCategoriesListRequest {
  String? categoryId;
  String? page;

  ProductCategoriesListRequest({this.categoryId, this.page});

  ProductCategoriesListRequest.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['page'] = this.page;
    return data;
  }
}
