// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pied_fort.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PiedFortAdapter extends TypeAdapter<PiedFort> {
  @override
  final int typeId = 109;

  @override
  PiedFort read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PiedFort.gauche;
      case 1:
        return PiedFort.droit;
      case 2:
        return PiedFort.lesDeux;
      default:
        return PiedFort.gauche;
    }
  }

  @override
  void write(BinaryWriter writer, PiedFort obj) {
    switch (obj) {
      case PiedFort.gauche:
        writer.writeByte(0);
        break;
      case PiedFort.droit:
        writer.writeByte(1);
        break;
      case PiedFort.lesDeux:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PiedFortAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
