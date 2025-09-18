// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_but.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeButAdapter extends TypeAdapter<TypeBut> {
  @override
  final int typeId = 111;

  @override
  TypeBut read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeBut.tir;
      case 1:
        return TypeBut.tete;
      case 2:
        return TypeBut.coupFranc;
      case 3:
        return TypeBut.penalty;
      case 4:
        return TypeBut.contreSonCamp;
      default:
        return TypeBut.tir;
    }
  }

  @override
  void write(BinaryWriter writer, TypeBut obj) {
    switch (obj) {
      case TypeBut.tir:
        writer.writeByte(0);
        break;
      case TypeBut.tete:
        writer.writeByte(1);
        break;
      case TypeBut.coupFranc:
        writer.writeByte(2);
        break;
      case TypeBut.penalty:
        writer.writeByte(3);
        break;
      case TypeBut.contreSonCamp:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeButAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
