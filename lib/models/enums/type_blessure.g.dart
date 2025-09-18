// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_blessure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeBlessureAdapter extends TypeAdapter<TypeBlessure> {
  @override
  final int typeId = 116;

  @override
  TypeBlessure read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeBlessure.musculaire;
      case 1:
        return TypeBlessure.ligamentaire;
      case 2:
        return TypeBlessure.fracture;
      case 3:
        return TypeBlessure.commotion;
      case 4:
        return TypeBlessure.autre;
      default:
        return TypeBlessure.musculaire;
    }
  }

  @override
  void write(BinaryWriter writer, TypeBlessure obj) {
    switch (obj) {
      case TypeBlessure.musculaire:
        writer.writeByte(0);
        break;
      case TypeBlessure.ligamentaire:
        writer.writeByte(1);
        break;
      case TypeBlessure.fracture:
        writer.writeByte(2);
        break;
      case TypeBlessure.commotion:
        writer.writeByte(3);
        break;
      case TypeBlessure.autre:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeBlessureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
