// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompetitionAdapter extends TypeAdapter<Competition> {
  @override
  final int typeId = 25;

  @override
  Competition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Competition(
      id: fields[0] as int,
      nom: fields[1] as String,
      type: fields[2] as TypeCompetition,
      niveau: fields[3] as NiveauCompetition,
      saison: fields[4] as String,
      dateDebut: fields[5] as DateTime,
      dateFin: fields[6] as DateTime,
      nombreEquipes: fields[7] as int,
      format: fields[8] as FormatCompetition,
      dotation: fields[9] as double,
      sponsor: fields[10] as String,
      organisateur: fields[11] as String,
      reglements: fields[12] as String,
      palmares: (fields[13] as List).cast<Palmares>(),
      classement: fields[14] as Classement,
    );
  }

  @override
  void write(BinaryWriter writer, Competition obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.niveau)
      ..writeByte(4)
      ..write(obj.saison)
      ..writeByte(5)
      ..write(obj.dateDebut)
      ..writeByte(6)
      ..write(obj.dateFin)
      ..writeByte(7)
      ..write(obj.nombreEquipes)
      ..writeByte(8)
      ..write(obj.format)
      ..writeByte(9)
      ..write(obj.dotation)
      ..writeByte(10)
      ..write(obj.sponsor)
      ..writeByte(11)
      ..write(obj.organisateur)
      ..writeByte(12)
      ..write(obj.reglements)
      ..writeByte(13)
      ..write(obj.palmares)
      ..writeByte(14)
      ..write(obj.classement);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompetitionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
