class PaginationModel {
  String? categoryId;
  String? page;
  String? sortName;
  String? sortOrder;
  String? search;

  PaginationModel(
      {this.categoryId, this.page, this.sortName, this.sortOrder, this.search});

  PaginationModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    page = json['page'];
    sortName = json['sortname'];
    sortOrder = json['sortorder'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['page'] = this.page;
    data['sortname'] = this.sortName;
    data['sortorder'] = this.sortOrder;
    data['search'] = this.search;
    return data;
  }

  @override
  String toString() {
    return 'PaginationModel{categoryId: $categoryId, page: $page,search: $search, sortName: $sortName, sortOrder: $sortOrder}';
  }
}
