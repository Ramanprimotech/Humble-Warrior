class PaginationModel {
  String? page;

  PaginationModel({this.page});

  PaginationModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    return data;
  }
}
