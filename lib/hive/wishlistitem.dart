// import 'package:hive_flutter/hive_flutter.dart';
//
// part 'wishlistitem.g.dart';
//
// @HiveType(typeId: 1)
// class Wishlistitem {
//   @HiveField(0)
//   final String image;
//
//   @HiveField(1)
//   final String dealName;
//
//   @HiveField(2)
//   final String productId;
//
//   @HiveField(3)
//   final String shop;
//
//   @HiveField(4)
//   final String code;
//
//   @HiveField(5)
//   final String type;
//   //
//   // @HiveField(6, defaultValue: [])
//   // List<Wishlistitem>? items;
//   Wishlistitem(
//       // this.items,
//       {required this.image,
//       required this.dealName,
//       required this.productId,
//       required this.shop,
//       required this.code,
//       required this.type});
//
//   @override
//   String toString() {
//     return 'Wishlistitem{image: $image, dealName: $dealName, productId: $productId, shop: $shop, code: $code, type: $type}';
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Wishlistitem &&
//           runtimeType == other.runtimeType &&
//           image == other.image &&
//           dealName == other.dealName &&
//           productId == other.productId &&
//           shop == other.shop &&
//           code == other.code &&
//           type == other.type;
//
//   @override
//   int get hashCode =>
//       image.hashCode ^
//       dealName.hashCode ^
//       productId.hashCode ^
//       shop.hashCode ^
//       code.hashCode ^
//       type.hashCode;
// }
