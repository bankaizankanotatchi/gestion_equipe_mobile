// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suivi_blessure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SuiviBlessureAdapter extends TypeAdapter<SuiviBlessure> {
  @override
  final int typeId = 12;

  @override
  SuiviBlessure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SuiviBlessure(
      id: fields[0] as int,
      dateVisite: fields[1] as DateTime,
      evolution: fields[2] as String,
      douleur: fields[3] as int,
      mobilite: fields[4] as int,
      recommandations: fields[5] as String,
      prochainRendezVous: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SuiviBlessure obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateVisite)
      ..writeByte(2)
      ..write(obj.evolution)
      ..writeByte(3)
      ..write(obj.douleur)
      ..writeByte(4)
      ..write(obj.mobilite)
      ..writeByte(5)
      ..write(obj.recommandations)
      ..writeByte(6)
      ..write(obj.prochainRendezVous);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuiviBlessureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
