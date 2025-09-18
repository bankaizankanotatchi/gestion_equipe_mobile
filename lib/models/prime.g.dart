// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prime.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrimeAdapter extends TypeAdapter<Prime> {
  @override
  final int typeId = 17;

  @override
  Prime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prime(
      id: fields[0] as int,
      type: fields[1] as TypePrime,
      montant: fields[2] as double,
      condition: fields[3] as String,
      atteinte: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Prime obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.montant)
      ..writeByte(3)
      ..write(obj.condition)
      ..writeByte(4)
      ..write(obj.atteinte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
