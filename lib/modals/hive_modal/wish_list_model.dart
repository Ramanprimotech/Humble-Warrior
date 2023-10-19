import 'package:humble_warrior/hw.dart';

@HiveType(typeId: 1)
class WishListModel{
  @HiveType(typeId: 0)
  String userid;
  @HiveType(typeId: 1)
  ProductDetailsResponse item;

  WishListModel({
     required this.userid,
     required this.item
});

  @override
  String toString() {
    return 'ProductDetailsResponse{userid: $userid, item: $item}';
  }

  WishListModel.fromJson(Map<String, dynamic> json, this.userid, this.item) {
    userid = json['userid'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['item'] = item;
    return data;
  }
}