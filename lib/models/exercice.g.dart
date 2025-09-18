// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciceAdapter extends TypeAdapter<Exercice> {
  @override
  final int typeId = 26;

  @override
  Exercice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercice(
      id: fields[0] as int,
      nom: fields[1] as String,
      description: fields[2] as String,
      duree: fields[3] as int,
      materiel: (fields[4] as List).cast<String>(),
      competencesTrainees: (fields[5] as List).cast<String>(),
      difficulte: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Exercice obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.duree)
      ..writeByte(4)
      ..write(obj.materiel)
      ..writeByte(5)
      ..write(obj.competencesTrainees)
      ..writeByte(6)
      ..write(obj.difficulte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
