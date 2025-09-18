// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entraineur_principal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntraineurPrincipalAdapter extends TypeAdapter<EntraineurPrincipal> {
  @override
  final int typeId = 20;

  @override
  EntraineurPrincipal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntraineurPrincipal(
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
      licenceEntraineur: fields[10] as String,
      niveauLicence: fields[11] as NiveauLicence,
      experience: fields[12] as int,
      salaire: fields[13] as double,
      tactiqueFavorite: fields[14] as String,
      systemeJeu: fields[15] as SystemeJeu,
      philosophieJeu: fields[16] as String,
      palmaresEntraineur: (fields[17] as List).cast<Palmares>(),
    );
  }

  @override
  void write(BinaryWriter writer, EntraineurPrincipal obj) {
    writer
      ..writeByte(18)
      ..writeByte(10)
      ..write(obj.licenceEntraineur)
      ..writeByte(11)
      ..write(obj.niveauLicence)
      ..writeByte(12)
      ..write(obj.experience)
      ..writeByte(13)
      ..write(obj.salaire)
      ..writeByte(14)
      ..write(obj.tactiqueFavorite)
      ..writeByte(15)
      ..write(obj.systemeJeu)
      ..writeByte(16)
      ..write(obj.philosophieJeu)
      ..writeByte(17)
      ..write(obj.palmaresEntraineur)
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
      other is EntraineurPrincipalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
