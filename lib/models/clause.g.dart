// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clause.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClauseAdapter extends TypeAdapter<Clause> {
  @override
  final int typeId = 18;

  @override
  Clause read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Clause(
      id: fields[0] as int,
      type: fields[1] as TypeClause,
      description: fields[2] as String,
      montant: fields[3] as double,
      conditions: fields[4] as String,
      active: fields[5] as bool,
      dateExpiration: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Clause obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.montant)
      ..writeByte(4)
      ..write(obj.conditions)
      ..writeByte(5)
      ..write(obj.active)
      ..writeByte(6)
      ..write(obj.dateExpiration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClauseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
