// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couleur_carton.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CouleurCartonAdapter extends TypeAdapter<CouleurCarton> {
  @override
  final int typeId = 113;

  @override
  CouleurCarton read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CouleurCarton.jaune;
      case 1:
        return CouleurCarton.rouge;
      default:
        return CouleurCarton.jaune;
    }
  }

  @override
  void write(BinaryWriter writer, CouleurCarton obj) {
    switch (obj) {
      case CouleurCarton.jaune:
        writer.writeByte(0);
        break;
      case CouleurCarton.rouge:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouleurCartonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
