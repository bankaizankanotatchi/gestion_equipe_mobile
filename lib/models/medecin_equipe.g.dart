// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medecin_equipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedecinEquipeAdapter extends TypeAdapter<MedecinEquipe> {
  @override
  final int typeId = 5;

  @override
  MedecinEquipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedecinEquipe(
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
      role: fields[10] as RoleStaff,
      specialite: fields[11] as String,
      certification: fields[12] as String,
      experience: fields[13] as int,
      numeroOrdre: fields[14] as String,
      specialitesMedicales: (fields[15] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MedecinEquipe obj) {
    writer
      ..writeByte(16)
      ..writeByte(14)
      ..write(obj.numeroOrdre)
      ..writeByte(15)
      ..write(obj.specialitesMedicales)
      ..writeByte(10)
      ..write(obj.role)
      ..writeByte(11)
      ..write(obj.specialite)
      ..writeByte(12)
      ..write(obj.certification)
      ..writeByte(13)
      ..write(obj.experience)
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
      other is MedecinEquipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
