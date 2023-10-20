import 'package:humble_warrior/hw.dart';

part 'wish_list_model.g.dart';

@HiveType(typeId: 0)
class WishListModel {
  @HiveField(0)
  final String userid;

  @HiveField(1)
  final ProductDetailsResponse item;

  const WishListModel(this.userid, this.item); // Constructor

  // Convert WishListModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'item': item.toJson(), // Assuming ProductDetailsResponse has a toJson method
    };
  }

  // Create a factory method to create WishListModel from a Map
  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      json['userid'] as String,
      ProductDetailsResponse.fromJson(json['item']),
    );
  }
}

