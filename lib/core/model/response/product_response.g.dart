// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductResponseAdapter extends TypeAdapter<ProductResponse> {
  @override
  final int typeId = 0;

  @override
  ProductResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductResponse(
      id: fields[0] as int?,
      title: fields[1] as String?,
      price: fields[2] as int?,
      quantity: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
