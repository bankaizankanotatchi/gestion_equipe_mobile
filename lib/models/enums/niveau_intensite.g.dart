// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niveau_intensite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NiveauIntensiteAdapter extends TypeAdapter<NiveauIntensite> {
  @override
  final int typeId = 126;

  @override
  NiveauIntensite read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NiveauIntensite.faible;
      case 1:
        return NiveauIntensite.moyen;
      case 2:
        return NiveauIntensite.eleve;
      default:
        return NiveauIntensite.faible;
    }
  }

  @override
  void write(BinaryWriter writer, NiveauIntensite obj) {
    switch (obj) {
      case NiveauIntensite.faible:
        writer.writeByte(0);
        break;
      case NiveauIntensite.moyen:
        writer.writeByte(1);
        break;
      case NiveauIntensite.eleve:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NiveauIntensiteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
