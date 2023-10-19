// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishListModelAdapter extends TypeAdapter<WishListModel> {
  @override
  final int typeId = 3;

  @override
  WishListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishListModel();
  }

  @override
  void write(BinaryWriter writer, WishListModel obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
