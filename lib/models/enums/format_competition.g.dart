// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'format_competition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormatCompetitionAdapter extends TypeAdapter<FormatCompetition> {
  @override
  final int typeId = 121;

  @override
  FormatCompetition read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FormatCompetition.championnat;
      case 1:
        return FormatCompetition.coupe;
      case 2:
        return FormatCompetition.groupes;
      case 3:
        return FormatCompetition.eliminationDirecte;
      default:
        return FormatCompetition.championnat;
    }
  }

  @override
  void write(BinaryWriter writer, FormatCompetition obj) {
    switch (obj) {
      case FormatCompetition.championnat:
        writer.writeByte(0);
        break;
      case FormatCompetition.coupe:
        writer.writeByte(1);
        break;
      case FormatCompetition.groupes:
        writer.writeByte(2);
        break;
      case FormatCompetition.eliminationDirecte:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatCompetitionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
