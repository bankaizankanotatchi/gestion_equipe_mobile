// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompositionAdapter extends TypeAdapter<Composition> {
  @override
  final int typeId = 10;

  @override
  Composition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Composition(
      id: fields[0] as int,
      systemeJeu: fields[1] as SystemeJeu,
      dateComposition: fields[2] as DateTime,
      titulaires: (fields[3] as List).cast<Joueur>(),
      remplacants: (fields[4] as List).cast<Joueur>(),
      capitaine: fields[5] as Joueur,
      tireursPenalty: (fields[6] as List).cast<Joueur>(),
      tireursCoups: (fields[7] as List).cast<Joueur>(),
      validee: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Composition obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.systemeJeu)
      ..writeByte(2)
      ..write(obj.dateComposition)
      ..writeByte(3)
      ..write(obj.titulaires)
      ..writeByte(4)
      ..write(obj.remplacants)
      ..writeByte(5)
      ..write(obj.capitaine)
      ..writeByte(6)
      ..write(obj.tireursPenalty)
      ..writeByte(7)
      ..write(obj.tireursCoups)
      ..writeByte(8)
      ..write(obj.validee);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
