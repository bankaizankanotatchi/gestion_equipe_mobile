// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periode_match.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeriodeMatchAdapter extends TypeAdapter<PeriodeMatch> {
  @override
  final int typeId = 115;

  @override
  PeriodeMatch read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PeriodeMatch.premiereMiTemps;
      case 1:
        return PeriodeMatch.deuxiemeMiTemps;
      case 2:
        return PeriodeMatch.prolongation;
      case 3:
        return PeriodeMatch.tirsAuBut;
      default:
        return PeriodeMatch.premiereMiTemps;
    }
  }

  @override
  void write(BinaryWriter writer, PeriodeMatch obj) {
    switch (obj) {
      case PeriodeMatch.premiereMiTemps:
        writer.writeByte(0);
        break;
      case PeriodeMatch.deuxiemeMiTemps:
        writer.writeByte(1);
        break;
      case PeriodeMatch.prolongation:
        writer.writeByte(2);
        break;
      case PeriodeMatch.tirsAuBut:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodeMatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
