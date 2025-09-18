// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_classement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionClassementAdapter extends TypeAdapter<PositionClassement> {
  @override
  final int typeId = 23;

  @override
  PositionClassement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionClassement(
      position: fields[0] as int,
      points: fields[1] as int,
      matchsJoues: fields[2] as int,
      victoires: fields[3] as int,
      nuls: fields[4] as int,
      defaites: fields[5] as int,
      butsMarques: fields[6] as int,
      butsEncaisses: fields[7] as int,
      difference: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PositionClassement obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.position)
      ..writeByte(1)
      ..write(obj.points)
      ..writeByte(2)
      ..write(obj.matchsJoues)
      ..writeByte(3)
      ..write(obj.victoires)
      ..writeByte(4)
      ..write(obj.nuls)
      ..writeByte(5)
      ..write(obj.defaites)
      ..writeByte(6)
      ..write(obj.butsMarques)
      ..writeByte(7)
      ..write(obj.butsEncaisses)
      ..writeByte(8)
      ..write(obj.difference);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionClassementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
