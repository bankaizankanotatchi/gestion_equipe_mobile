// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niveau_competition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NiveauCompetitionAdapter extends TypeAdapter<NiveauCompetition> {
  @override
  final int typeId = 120;

  @override
  NiveauCompetition read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NiveauCompetition.local;
      case 1:
        return NiveauCompetition.national;
      case 2:
        return NiveauCompetition.continental;
      case 3:
        return NiveauCompetition.mondial;
      default:
        return NiveauCompetition.local;
    }
  }

  @override
  void write(BinaryWriter writer, NiveauCompetition obj) {
    switch (obj) {
      case NiveauCompetition.local:
        writer.writeByte(0);
        break;
      case NiveauCompetition.national:
        writer.writeByte(1);
        break;
      case NiveauCompetition.continental:
        writer.writeByte(2);
        break;
      case NiveauCompetition.mondial:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NiveauCompetitionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
