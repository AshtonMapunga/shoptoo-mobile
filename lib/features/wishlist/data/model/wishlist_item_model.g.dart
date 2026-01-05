// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistItemModelAdapter extends TypeAdapter<WishlistItemModel> {
  @override
  final int typeId = 1;

  @override
  WishlistItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistItemModel(
      productId: fields[0] as int,
      name: fields[1] as String,
      image: fields[2] as String,
      price: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishlistItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
