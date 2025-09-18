// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statut_joueur.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatutJoueurAdapter extends TypeAdapter<StatutJoueur> {
  @override
  final int typeId = 101;

  @override
  StatutJoueur read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StatutJoueur.actif;
      case 1:
        return StatutJoueur.blesse;
      case 2:
        return StatutJoueur.suspendu;
      case 3:
        return StatutJoueur.pret;
      case 4:
        return StatutJoueur.reserve;
      case 5:
        return StatutJoueur.international;
      case 6:
        return StatutJoueur.retraite;
      case 7:
        return StatutJoueur.transfertCours;
      default:
        return StatutJoueur.actif;
    }
  }

  @override
  void write(BinaryWriter writer, StatutJoueur obj) {
    switch (obj) {
      case StatutJoueur.actif:
        writer.writeByte(0);
        break;
      case StatutJoueur.blesse:
        writer.writeByte(1);
        break;
      case StatutJoueur.suspendu:
        writer.writeByte(2);
        break;
      case StatutJoueur.pret:
        writer.writeByte(3);
        break;
      case StatutJoueur.reserve:
        writer.writeByte(4);
        break;
      case StatutJoueur.international:
        writer.writeByte(5);
        break;
      case StatutJoueur.retraite:
        writer.writeByte(6);
        break;
      case StatutJoueur.transfertCours:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatutJoueurAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
