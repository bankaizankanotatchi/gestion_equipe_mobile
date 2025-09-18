// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrainement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntrainementAdapter extends TypeAdapter<Entrainement> {
  @override
  final int typeId = 27;

  @override
  Entrainement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Entrainement(
      id: fields[0] as int,
      dateEntrainement: fields[1] as DateTime,
      duree: fields[2] as int,
      type: fields[3] as TypeEntrainement,
      intensite: fields[4] as NiveauIntensite,
      objectifs: (fields[5] as List).cast<String>(),
      exercices: (fields[6] as List).cast<Exercice>(),
      participantsPresents: (fields[7] as List).cast<Joueur>(),
      participantsAbsents: (fields[8] as List).cast<Joueur>(),
      conditions: fields[9] as ConditionsMeteo,
    );
  }

  @override
  void write(BinaryWriter writer, Entrainement obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateEntrainement)
      ..writeByte(2)
      ..write(obj.duree)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.intensite)
      ..writeByte(5)
      ..write(obj.objectifs)
      ..writeByte(6)
      ..write(obj.exercices)
      ..writeByte(7)
      ..write(obj.participantsPresents)
      ..writeByte(8)
      ..write(obj.participantsAbsents)
      ..writeByte(9)
      ..write(obj.conditions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntrainementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
