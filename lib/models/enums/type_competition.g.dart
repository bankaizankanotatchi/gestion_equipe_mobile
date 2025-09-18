// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_competition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeCompetitionAdapter extends TypeAdapter<TypeCompetition> {
  @override
  final int typeId = 105;

  @override
  TypeCompetition read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeCompetition.championnat;
      case 1:
        return TypeCompetition.coupeNationale;
      case 2:
        return TypeCompetition.coupeEuropeenne;
      case 3:
        return TypeCompetition.coupeMonde;
      case 4:
        return TypeCompetition.matchAmical;
      case 5:
        return TypeCompetition.tournoi;
      case 6:
        return TypeCompetition.qualification;
      default:
        return TypeCompetition.championnat;
    }
  }

  @override
  void write(BinaryWriter writer, TypeCompetition obj) {
    switch (obj) {
      case TypeCompetition.championnat:
        writer.writeByte(0);
        break;
      case TypeCompetition.coupeNationale:
        writer.writeByte(1);
        break;
      case TypeCompetition.coupeEuropeenne:
        writer.writeByte(2);
        break;
      case TypeCompetition.coupeMonde:
        writer.writeByte(3);
        break;
      case TypeCompetition.matchAmical:
        writer.writeByte(4);
        break;
      case TypeCompetition.tournoi:
        writer.writeByte(5);
        break;
      case TypeCompetition.qualification:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeCompetitionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
