// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niveau_importance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NiveauImportanceAdapter extends TypeAdapter<NiveauImportance> {
  @override
  final int typeId = 127;

  @override
  NiveauImportance read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NiveauImportance.faible;
      case 1:
        return NiveauImportance.moyen;
      case 2:
        return NiveauImportance.eleve;
      default:
        return NiveauImportance.faible;
    }
  }

  @override
  void write(BinaryWriter writer, NiveauImportance obj) {
    switch (obj) {
      case NiveauImportance.faible:
        writer.writeByte(0);
        break;
      case NiveauImportance.moyen:
        writer.writeByte(1);
        break;
      case NiveauImportance.eleve:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NiveauImportanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
