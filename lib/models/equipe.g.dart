// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquipeAdapter extends TypeAdapter<Equipe> {
  @override
  final int typeId = 8;

  @override
  Equipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Equipe(
      id: fields[0] as int,
      nom: fields[1] as String,
      nomCourt: fields[2] as String,
      ville: fields[3] as String,
      couleurPrincipale: fields[4] as String,
      couleurSecondaire: fields[5] as String,
      dateCreation: fields[6] as DateTime,
      budget: fields[7] as double,
      massesSalariales: fields[8] as double,
      logo: fields[9] as String,
      hymne: fields[10] as String,
      president: fields[11] as String,
      directeurSportif: fields[12] as String,
      centreEntrainement: fields[13] as String,
      supporteurs: fields[14] as int,
      palmares: (fields[15] as List).cast<Palmares>(),
      joueurs: (fields[16] as List).cast<Joueur>(),
      staffs: (fields[17] as List).cast<Staff>(),
      stade: fields[18] as Stade,
      sponsors: (fields[19] as List).cast<Sponsor>(),
    );
  }

  @override
  void write(BinaryWriter writer, Equipe obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.nomCourt)
      ..writeByte(3)
      ..write(obj.ville)
      ..writeByte(4)
      ..write(obj.couleurPrincipale)
      ..writeByte(5)
      ..write(obj.couleurSecondaire)
      ..writeByte(6)
      ..write(obj.dateCreation)
      ..writeByte(7)
      ..write(obj.budget)
      ..writeByte(8)
      ..write(obj.massesSalariales)
      ..writeByte(9)
      ..write(obj.logo)
      ..writeByte(10)
      ..write(obj.hymne)
      ..writeByte(11)
      ..write(obj.president)
      ..writeByte(12)
      ..write(obj.directeurSportif)
      ..writeByte(13)
      ..write(obj.centreEntrainement)
      ..writeByte(14)
      ..write(obj.supporteurs)
      ..writeByte(15)
      ..write(obj.palmares)
      ..writeByte(16)
      ..write(obj.joueurs)
      ..writeByte(17)
      ..write(obj.staffs)
      ..writeByte(18)
      ..write(obj.stade)
      ..writeByte(19)
      ..write(obj.sponsors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
