// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'wishlistitem.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
// class WishlistitemAdapter extends TypeAdapter<Wishlistitem> {
//   @override
//   final int typeId = 1;
//
//   @override
//   Wishlistitem read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Wishlistitem(
//       image: fields[0] as String,
//       dealName: fields[1] as String,
//       productId: fields[2] as String,
//       shop: fields[3] as String,
//       code: fields[4] as String,
//       type: fields[5] as String,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, Wishlistitem obj) {
//     writer
//       ..writeByte(6)
//       ..writeByte(0)
//       ..write(obj.image)
//       ..writeByte(1)
//       ..write(obj.dealName)
//       ..writeByte(2)
//       ..write(obj.productId)
//       ..writeByte(3)
//       ..write(obj.shop)
//       ..writeByte(4)
//       ..write(obj.code)
//       ..writeByte(5)
//       ..write(obj.type);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is WishlistitemAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
