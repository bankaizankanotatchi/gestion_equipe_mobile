// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_entrainement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeEntrainementAdapter extends TypeAdapter<TypeEntrainement> {
  @override
  final int typeId = 125;

  @override
  TypeEntrainement read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeEntrainement.physique;
      case 1:
        return TypeEntrainement.tactique;
      case 2:
        return TypeEntrainement.technique;
      case 3:
        return TypeEntrainement.mental;
      case 4:
        return TypeEntrainement.recuperation;
      default:
        return TypeEntrainement.physique;
    }
  }

  @override
  void write(BinaryWriter writer, TypeEntrainement obj) {
    switch (obj) {
      case TypeEntrainement.physique:
        writer.writeByte(0);
        break;
      case TypeEntrainement.tactique:
        writer.writeByte(1);
        break;
      case TypeEntrainement.technique:
        writer.writeByte(2);
        break;
      case TypeEntrainement.mental:
        writer.writeByte(3);
        break;
      case TypeEntrainement.recuperation:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeEntrainementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
