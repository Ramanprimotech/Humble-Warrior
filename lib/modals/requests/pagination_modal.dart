class PaginationModel {
  String? categoryId;
  String? page;
  String? sortName;
  String? sortOrder;
  String? search;
  String? postType;
  List<int>? catIds;

  PaginationModel(
      {this.categoryId,
      this.page,
      this.sortName,
      this.sortOrder,
      this.search,
      this.postType,
      this.catIds});

  PaginationModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    page = json['page'];
    sortName = json['sortname'];
    sortOrder = json['sortorder'];
    search = json['search'];
    postType = json['post_type'];
    catIds = json['cat_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['page'] = page;
    data['sortname'] = sortName;
    data['sortorder'] = sortOrder;
    data['search'] = search;
    data['post_type'] = postType;
    data['cat_ids'] = catIds;
    return data;
  }

  @override
  String toString() {
    return 'PaginationModel{categoryId: $categoryId, page: $page,search: $search, sortName: $sortName, sortOrder: $sortOrder , postType: $postType, catIDs : $catIds}';
  }
}
