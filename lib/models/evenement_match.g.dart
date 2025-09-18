// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evenement_match.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EvenementMatchAdapter extends TypeAdapter<EvenementMatch> {
  @override
  final int typeId = 11;

  @override
  EvenementMatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EvenementMatch(
      id: fields[0] as int,
      minute: fields[1] as int,
      type: fields[2] as TypeEvenement,
      description: fields[3] as String,
      periode: fields[4] as PeriodeMatch,
      importance: fields[5] as NiveauImportance,
      visible: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EvenementMatch obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.minute)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.periode)
      ..writeByte(5)
      ..write(obj.importance)
      ..writeByte(6)
      ..write(obj.visible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EvenementMatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
