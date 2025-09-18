// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blessure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlessureAdapter extends TypeAdapter<Blessure> {
  @override
  final int typeId = 13;

  @override
  Blessure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Blessure(
      id: fields[0] as int,
      type: fields[1] as TypeBlessure,
      gravite: fields[2] as GraviteBlessure,
      dateBlessure: fields[3] as DateTime,
      dureeEstimee: fields[4] as int,
      dureeReelle: fields[5] as int,
      description: fields[6] as String,
      soigne: fields[7] as bool,
      dateRetour: fields[8] as DateTime,
      circumstancesBlessure: fields[9] as String,
      traitement: fields[10] as String,
      suivi: (fields[11] as List).cast<SuiviBlessure>(),
      recidive: fields[12] as bool,
      impactCarriere: fields[13] as ImpactCarriere,
    );
  }

  @override
  void write(BinaryWriter writer, Blessure obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.gravite)
      ..writeByte(3)
      ..write(obj.dateBlessure)
      ..writeByte(4)
      ..write(obj.dureeEstimee)
      ..writeByte(5)
      ..write(obj.dureeReelle)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.soigne)
      ..writeByte(8)
      ..write(obj.dateRetour)
      ..writeByte(9)
      ..write(obj.circumstancesBlessure)
      ..writeByte(10)
      ..write(obj.traitement)
      ..writeByte(11)
      ..write(obj.suivi)
      ..writeByte(12)
      ..write(obj.recidive)
      ..writeByte(13)
      ..write(obj.impactCarriere);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlessureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
