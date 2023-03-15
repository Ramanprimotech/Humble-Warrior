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
  int? date;
  String? thumbnail;
  bool? read;

  Posts({this.id, this.title, this.date, this.thumbnail, this.read});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    thumbnail = json['thumbnail'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['thumbnail'] = this.thumbnail;
    data['read'] = this.read;
    return data;
  }
}
