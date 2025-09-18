// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stade.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StadeAdapter extends TypeAdapter<Stade> {
  @override
  final int typeId = 21;

  @override
  Stade read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stade(
      id: fields[0] as int,
      nom: fields[1] as String,
      ville: fields[2] as String,
      capacite: fields[3] as int,
      capaciteVIP: fields[4] as int,
      typePelouse: fields[5] as TypePelouse,
      dimensions: fields[6] as String,
      longueur: fields[7] as double,
      largeur: fields[8] as double,
      adresse: fields[9] as String,
      dateConstruction: fields[10] as DateTime,
      dateRenovation: fields[11] as DateTime,
      equipements: (fields[12] as List).cast<String>(),
      parking: fields[13] as int,
      accessibilite: fields[14] as bool,
      certification: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Stade obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.ville)
      ..writeByte(3)
      ..write(obj.capacite)
      ..writeByte(4)
      ..write(obj.capaciteVIP)
      ..writeByte(5)
      ..write(obj.typePelouse)
      ..writeByte(6)
      ..write(obj.dimensions)
      ..writeByte(7)
      ..write(obj.longueur)
      ..writeByte(8)
      ..write(obj.largeur)
      ..writeByte(9)
      ..write(obj.adresse)
      ..writeByte(10)
      ..write(obj.dateConstruction)
      ..writeByte(11)
      ..write(obj.dateRenovation)
      ..writeByte(12)
      ..write(obj.equipements)
      ..writeByte(13)
      ..write(obj.parking)
      ..writeByte(14)
      ..write(obj.accessibilite)
      ..writeByte(15)
      ..write(obj.certification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StadeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
