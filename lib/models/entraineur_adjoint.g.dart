// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entraineur_adjoint.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntraineurAdjointAdapter extends TypeAdapter<EntraineurAdjoint> {
  @override
  final int typeId = 21;

  @override
  EntraineurAdjoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntraineurAdjoint(
      id: fields[0] as int,
      nom: fields[1] as String,
      prenom: fields[2] as String,
      dateNaissance: fields[3] as DateTime,
      telephone: fields[4] as String,
      email: fields[5] as String,
      adresse: fields[6] as String,
      nationalite: fields[7] as String,
      numeroPasseport: fields[8] as String,
      numeroIdentite: fields[9] as String,
      specialite: fields[10] as String,
      licenceEntraineur: fields[11] as String,
      niveauResponsabilite: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EntraineurAdjoint obj) {
    writer
      ..writeByte(13)
      ..writeByte(10)
      ..write(obj.specialite)
      ..writeByte(11)
      ..write(obj.licenceEntraineur)
      ..writeByte(12)
      ..write(obj.niveauResponsabilite)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.prenom)
      ..writeByte(3)
      ..write(obj.dateNaissance)
      ..writeByte(4)
      ..write(obj.telephone)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.adresse)
      ..writeByte(7)
      ..write(obj.nationalite)
      ..writeByte(8)
      ..write(obj.numeroPasseport)
      ..writeByte(9)
      ..write(obj.numeroIdentite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntraineurAdjointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
