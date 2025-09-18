// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassementAdapter extends TypeAdapter<Classement> {
  @override
  final int typeId = 24;

  @override
  Classement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Classement(
      id: fields[0] as int,
      saison: fields[1] as String,
      positions: (fields[2] as List).cast<PositionClassement>(),
      derniereMiseAJour: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Classement obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.saison)
      ..writeByte(2)
      ..write(obj.positions)
      ..writeByte(3)
      ..write(obj.derniereMiseAJour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
