import 'package:humble_warrior/hw.dart';
part 'wish_list_model.g.dart';

@HiveType(typeId: 0)
class WishListModel {
  @HiveField(0)
  final String userid;

  @HiveField(1)
  final ProductDetailsResponse item;

  const WishListModel(this.userid, this.item); // Constructor

  // Add a no-argument factory constructor for Hive
  // factory WishListModel.empty() {
  //   return WishListModel("", ProductDetailsResponse());
  // }
}