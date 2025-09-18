// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_pelouse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypePelouseAdapter extends TypeAdapter<TypePelouse> {
  @override
  final int typeId = 119;

  @override
  TypePelouse read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypePelouse.naturelle;
      case 1:
        return TypePelouse.synthetique;
      case 2:
        return TypePelouse.hybride;
      default:
        return TypePelouse.naturelle;
    }
  }

  @override
  void write(BinaryWriter writer, TypePelouse obj) {
    switch (obj) {
      case TypePelouse.naturelle:
        writer.writeByte(0);
        break;
      case TypePelouse.synthetique:
        writer.writeByte(1);
        break;
      case TypePelouse.hybride:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypePelouseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
