// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gardien.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GardienAdapter extends TypeAdapter<Gardien> {
  @override
  final int typeId = 2;

  @override
  Gardien read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gardien(
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
      numeroMaillot: fields[10] as int,
      poste: fields[11] as PosteJoueur,
      postesSecondaires: (fields[12] as List).cast<PosteJoueur>(),
      piedFort: fields[13] as PiedFort,
      taille: fields[14] as double,
      poids: fields[15] as double,
      salaire: fields[16] as double,
      dateContrat: fields[17] as DateTime,
      finContrat: fields[18] as DateTime,
      statut: fields[19] as StatutJoueur,
      blessure: fields[20] as bool,
      suspension: fields[21] as bool,
      valeurMarchande: fields[22] as double,
      formationInitiale: fields[23] as String,
      languesParlees: (fields[24] as List).cast<String>(),
      tailleGants: fields[25] as int,
      styleJeu: fields[26] as StyleGardien,
      arretsReflexes: fields[27] as int,
      sortiesAeriennes: fields[28] as int,
      relancePied: fields[29] as int,
      relanceMains: fields[30] as int,
      commandementSurface: fields[31] as int,
      penaltiesArrets: fields[32] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Gardien obj) {
    writer
      ..writeByte(33)
      ..writeByte(25)
      ..write(obj.tailleGants)
      ..writeByte(26)
      ..write(obj.styleJeu)
      ..writeByte(27)
      ..write(obj.arretsReflexes)
      ..writeByte(28)
      ..write(obj.sortiesAeriennes)
      ..writeByte(29)
      ..write(obj.relancePied)
      ..writeByte(30)
      ..write(obj.relanceMains)
      ..writeByte(31)
      ..write(obj.commandementSurface)
      ..writeByte(32)
      ..write(obj.penaltiesArrets)
      ..writeByte(10)
      ..write(obj.numeroMaillot)
      ..writeByte(11)
      ..write(obj.poste)
      ..writeByte(12)
      ..write(obj.postesSecondaires)
      ..writeByte(13)
      ..write(obj.piedFort)
      ..writeByte(14)
      ..write(obj.taille)
      ..writeByte(15)
      ..write(obj.poids)
      ..writeByte(16)
      ..write(obj.salaire)
      ..writeByte(17)
      ..write(obj.dateContrat)
      ..writeByte(18)
      ..write(obj.finContrat)
      ..writeByte(19)
      ..write(obj.statut)
      ..writeByte(20)
      ..write(obj.blessure)
      ..writeByte(21)
      ..write(obj.suspension)
      ..writeByte(22)
      ..write(obj.valeurMarchande)
      ..writeByte(23)
      ..write(obj.formationInitiale)
      ..writeByte(24)
      ..write(obj.languesParlees)
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
      other is GardienAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
