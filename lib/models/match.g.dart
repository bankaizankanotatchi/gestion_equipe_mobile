// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchAdapter extends TypeAdapter<Match> {
  @override
  final int typeId = 9;

  @override
  Match read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Match(
      id: fields[0] as int,
      dateMatch: fields[1] as DateTime,
      journee: fields[2] as int,
      scoreEquipeDomicile: fields[3] as int,
      scoreEquipeExterieur: fields[4] as int,
      statut: fields[5] as StatutMatch,
      arbitrePrincipal: fields[6] as String,
      arbitresAssistants: (fields[7] as List).cast<String>(),
      quatriemeArbitre: fields[8] as String,
      vars: fields[9] as String,
      conditions: fields[10] as ConditionsMeteo,
      temperature: fields[11] as double,
      spectateurs: fields[12] as int,
      recettes: fields[13] as double,
      televise: fields[14] as bool,
      commentaires: fields[15] as String,
      equipeDomicile: fields[16] as Equipe,
      equipeExterieur: fields[17] as Equipe,
      stade: fields[18] as Stade,
      competition: fields[19] as Competition,
      composition: fields[20] as Composition,
      evenements: (fields[21] as List).cast<EvenementMatch>(),
    );
  }

  @override
  void write(BinaryWriter writer, Match obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateMatch)
      ..writeByte(2)
      ..write(obj.journee)
      ..writeByte(3)
      ..write(obj.scoreEquipeDomicile)
      ..writeByte(4)
      ..write(obj.scoreEquipeExterieur)
      ..writeByte(5)
      ..write(obj.statut)
      ..writeByte(6)
      ..write(obj.arbitrePrincipal)
      ..writeByte(7)
      ..write(obj.arbitresAssistants)
      ..writeByte(8)
      ..write(obj.quatriemeArbitre)
      ..writeByte(9)
      ..write(obj.vars)
      ..writeByte(10)
      ..write(obj.conditions)
      ..writeByte(11)
      ..write(obj.temperature)
      ..writeByte(12)
      ..write(obj.spectateurs)
      ..writeByte(13)
      ..write(obj.recettes)
      ..writeByte(14)
      ..write(obj.televise)
      ..writeByte(15)
      ..write(obj.commentaires)
      ..writeByte(16)
      ..write(obj.equipeDomicile)
      ..writeByte(17)
      ..write(obj.equipeExterieur)
      ..writeByte(18)
      ..write(obj.stade)
      ..writeByte(19)
      ..write(obj.competition)
      ..writeByte(20)
      ..write(obj.composition)
      ..writeByte(21)
      ..write(obj.evenements);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
