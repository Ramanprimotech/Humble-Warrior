class NotificationResponseModel {
  List<Posts>? posts;
  int? timestamp;

  NotificationResponseModel({this.posts, this.timestamp});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class Posts {
  int? id;
  String? title;
  String? date;
  String? categoryName;
  String? thumbnail;
  bool? read;
  String? productDescription;

  Posts(
      {this.id,
      this.title,
      this.date,
      this.categoryName,
      this.thumbnail,
      this.productDescription,
      this.read});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    categoryName = json['category_name'];
    thumbnail = json['thumbnail'];
    productDescription = json['product_description'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['category_name'] = categoryName;
    data['thumbnail'] = thumbnail;
    data['product_description'] = productDescription;
    data['read'] = read;
    return data;
  }
}
