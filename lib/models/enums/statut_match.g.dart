// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statut_match.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatutMatchAdapter extends TypeAdapter<StatutMatch> {
  @override
  final int typeId = 103;

  @override
  StatutMatch read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StatutMatch.programme;
      case 1:
        return StatutMatch.enCours;
      case 2:
        return StatutMatch.miTemps;
      case 3:
        return StatutMatch.termine;
      case 4:
        return StatutMatch.reporte;
      case 5:
        return StatutMatch.annule;
      case 6:
        return StatutMatch.forfait;
      case 7:
        return StatutMatch.prolongations;
      case 8:
        return StatutMatch.tirsAuBut;
      default:
        return StatutMatch.programme;
    }
  }

  @override
  void write(BinaryWriter writer, StatutMatch obj) {
    switch (obj) {
      case StatutMatch.programme:
        writer.writeByte(0);
        break;
      case StatutMatch.enCours:
        writer.writeByte(1);
        break;
      case StatutMatch.miTemps:
        writer.writeByte(2);
        break;
      case StatutMatch.termine:
        writer.writeByte(3);
        break;
      case StatutMatch.reporte:
        writer.writeByte(4);
        break;
      case StatutMatch.annule:
        writer.writeByte(5);
        break;
      case StatutMatch.forfait:
        writer.writeByte(6);
        break;
      case StatutMatch.prolongations:
        writer.writeByte(7);
        break;
      case StatutMatch.tirsAuBut:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatutMatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
