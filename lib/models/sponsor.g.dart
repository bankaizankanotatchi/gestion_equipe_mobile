// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SponsorAdapter extends TypeAdapter<Sponsor> {
  @override
  final int typeId = 20;

  @override
  Sponsor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sponsor(
      id: fields[0] as int,
      nom: fields[1] as String,
      secteurActivite: fields[2] as String,
      montantSponsoring: fields[3] as double,
      dureeContrat: fields[4] as int,
      visibilite: (fields[5] as List).cast<String>(),
      droitsCommercials: (fields[6] as List).cast<String>(),
      activations: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Sponsor obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.secteurActivite)
      ..writeByte(3)
      ..write(obj.montantSponsoring)
      ..writeByte(4)
      ..write(obj.dureeContrat)
      ..writeByte(5)
      ..write(obj.visibilite)
      ..writeByte(6)
      ..write(obj.droitsCommercials)
      ..writeByte(7)
      ..write(obj.activations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SponsorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
