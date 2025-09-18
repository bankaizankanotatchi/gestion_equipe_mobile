// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_evenement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeEvenementAdapter extends TypeAdapter<TypeEvenement> {
  @override
  final int typeId = 102;

  @override
  TypeEvenement read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeEvenement.but;
      case 1:
        return TypeEvenement.cartonJaune;
      case 2:
        return TypeEvenement.cartonRouge;
      case 3:
        return TypeEvenement.remplacement;
      case 4:
        return TypeEvenement.penalty;
      case 5:
        return TypeEvenement.penaltyRate;
      case 6:
        return TypeEvenement.arretJeu;
      case 7:
        return TypeEvenement.horsJeu;
      case 8:
        return TypeEvenement.faute;
      case 9:
        return TypeEvenement.corner;
      case 10:
        return TypeEvenement.touche;
      case 11:
        return TypeEvenement.arretGardien;
      case 12:
        return TypeEvenement.parade;
      default:
        return TypeEvenement.but;
    }
  }

  @override
  void write(BinaryWriter writer, TypeEvenement obj) {
    switch (obj) {
      case TypeEvenement.but:
        writer.writeByte(0);
        break;
      case TypeEvenement.cartonJaune:
        writer.writeByte(1);
        break;
      case TypeEvenement.cartonRouge:
        writer.writeByte(2);
        break;
      case TypeEvenement.remplacement:
        writer.writeByte(3);
        break;
      case TypeEvenement.penalty:
        writer.writeByte(4);
        break;
      case TypeEvenement.penaltyRate:
        writer.writeByte(5);
        break;
      case TypeEvenement.arretJeu:
        writer.writeByte(6);
        break;
      case TypeEvenement.horsJeu:
        writer.writeByte(7);
        break;
      case TypeEvenement.faute:
        writer.writeByte(8);
        break;
      case TypeEvenement.corner:
        writer.writeByte(9);
        break;
      case TypeEvenement.touche:
        writer.writeByte(10);
        break;
      case TypeEvenement.arretGardien:
        writer.writeByte(11);
        break;
      case TypeEvenement.parade:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeEvenementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
