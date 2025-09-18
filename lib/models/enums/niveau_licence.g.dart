// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niveau_licence.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NiveauLicenceAdapter extends TypeAdapter<NiveauLicence> {
  @override
  final int typeId = 106;

  @override
  NiveauLicence read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NiveauLicence.debutant;
      case 1:
        return NiveauLicence.intermediaire;
      case 2:
        return NiveauLicence.avance;
      case 3:
        return NiveauLicence.pro;
      default:
        return NiveauLicence.debutant;
    }
  }

  @override
  void write(BinaryWriter writer, NiveauLicence obj) {
    switch (obj) {
      case NiveauLicence.debutant:
        writer.writeByte(0);
        break;
      case NiveauLicence.intermediaire:
        writer.writeByte(1);
        break;
      case NiveauLicence.avance:
        writer.writeByte(2);
        break;
      case NiveauLicence.pro:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NiveauLicenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
