class NotificationResponseModel {
  List<Posts>? posts;
  int? timestamp;

  NotificationResponseModel({this.posts, this.timestamp});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
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

  Posts(
      {this.id,
      this.title,
      this.date,
      this.categoryName,
      this.thumbnail,
      this.read});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    categoryName = json['category_name'];
    thumbnail = json['thumbnail'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['category_name'] = this.categoryName;
    data['thumbnail'] = this.thumbnail;
    data['read'] = this.read;
    return data;
  }
}
