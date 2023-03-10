// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDetailsResponseAdapter
    extends TypeAdapter<ProductDetailsResponse> {
  @override
  final int typeId = 1;

  @override
  ProductDetailsResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDetailsResponse(
      id: fields[0] as int?,
      itemName: fields[1] as String?,
      catName: fields[2] as String?,
      url: fields[3] as String?,
      shopUrl: fields[4] as String?,
      couponCode: fields[5] as String?,
      productDescription: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDetailsResponse obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.catName)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.shopUrl)
      ..writeByte(5)
      ..write(obj.couponCode)
      ..writeByte(6)
      ..write(obj.productDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
