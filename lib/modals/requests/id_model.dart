class IdModel {
  String? id;

  IdModel({this.id});

  IdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  @override
  String toString() {
    return 'IdModel{id: $id}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
