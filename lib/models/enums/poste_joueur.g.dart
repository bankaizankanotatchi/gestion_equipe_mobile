// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poste_joueur.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PosteJoueurAdapter extends TypeAdapter<PosteJoueur> {
  @override
  final int typeId = 100;

  @override
  PosteJoueur read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PosteJoueur.gardien;
      case 1:
        return PosteJoueur.defenseurCentral;
      case 2:
        return PosteJoueur.defenseurLateralDroit;
      case 3:
        return PosteJoueur.defenseurLateralGauche;
      case 4:
        return PosteJoueur.milieuDefensif;
      case 5:
        return PosteJoueur.milieuCentral;
      case 6:
        return PosteJoueur.milieuOffensif;
      case 7:
        return PosteJoueur.milieuRelayeur;
      case 8:
        return PosteJoueur.ailierDroit;
      case 9:
        return PosteJoueur.ailierGauche;
      case 10:
        return PosteJoueur.secondAttaquant;
      case 11:
        return PosteJoueur.attaquantCentre;
      case 12:
        return PosteJoueur.fauxNeuf;
      default:
        return PosteJoueur.gardien;
    }
  }

  @override
  void write(BinaryWriter writer, PosteJoueur obj) {
    switch (obj) {
      case PosteJoueur.gardien:
        writer.writeByte(0);
        break;
      case PosteJoueur.defenseurCentral:
        writer.writeByte(1);
        break;
      case PosteJoueur.defenseurLateralDroit:
        writer.writeByte(2);
        break;
      case PosteJoueur.defenseurLateralGauche:
        writer.writeByte(3);
        break;
      case PosteJoueur.milieuDefensif:
        writer.writeByte(4);
        break;
      case PosteJoueur.milieuCentral:
        writer.writeByte(5);
        break;
      case PosteJoueur.milieuOffensif:
        writer.writeByte(6);
        break;
      case PosteJoueur.milieuRelayeur:
        writer.writeByte(7);
        break;
      case PosteJoueur.ailierDroit:
        writer.writeByte(8);
        break;
      case PosteJoueur.ailierGauche:
        writer.writeByte(9);
        break;
      case PosteJoueur.secondAttaquant:
        writer.writeByte(10);
        break;
      case PosteJoueur.attaquantCentre:
        writer.writeByte(11);
        break;
      case PosteJoueur.fauxNeuf:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PosteJoueurAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
