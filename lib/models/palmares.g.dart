// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palmares.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PalmaresAdapter extends TypeAdapter<Palmares> {
  @override
  final int typeId = 19;

  @override
  Palmares read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Palmares(
      id: fields[0] as int,
      competition: fields[1] as String,
      saison: fields[2] as String,
      position: fields[3] as int,
      dateObtention: fields[4] as DateTime,
      titre: fields[5] as String,
      importance: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Palmares obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.competition)
      ..writeByte(2)
      ..write(obj.saison)
      ..writeByte(3)
      ..write(obj.position)
      ..writeByte(4)
      ..write(obj.dateObtention)
      ..writeByte(5)
      ..write(obj.titre)
      ..writeByte(6)
      ..write(obj.importance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PalmaresAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
