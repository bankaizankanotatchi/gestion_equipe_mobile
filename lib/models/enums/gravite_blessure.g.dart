// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gravite_blessure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GraviteBlessureAdapter extends TypeAdapter<GraviteBlessure> {
  @override
  final int typeId = 117;

  @override
  GraviteBlessure read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GraviteBlessure.legere;
      case 1:
        return GraviteBlessure.moyenne;
      case 2:
        return GraviteBlessure.grave;
      case 3:
        return GraviteBlessure.critique;
      default:
        return GraviteBlessure.legere;
    }
  }

  @override
  void write(BinaryWriter writer, GraviteBlessure obj) {
    switch (obj) {
      case GraviteBlessure.legere:
        writer.writeByte(0);
        break;
      case GraviteBlessure.moyenne:
        writer.writeByte(1);
        break;
      case GraviteBlessure.grave:
        writer.writeByte(2);
        break;
      case GraviteBlessure.critique:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GraviteBlessureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
