// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'systeme_jeu.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SystemeJeuAdapter extends TypeAdapter<SystemeJeu> {
  @override
  final int typeId = 104;

  @override
  SystemeJeu read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SystemeJeu.systeme433;
      case 1:
        return SystemeJeu.systeme442;
      case 2:
        return SystemeJeu.systeme352;
      case 3:
        return SystemeJeu.systeme343;
      case 4:
        return SystemeJeu.systeme4231;
      case 5:
        return SystemeJeu.systeme4321;
      case 6:
        return SystemeJeu.systeme532;
      case 7:
        return SystemeJeu.systeme541;
      default:
        return SystemeJeu.systeme433;
    }
  }

  @override
  void write(BinaryWriter writer, SystemeJeu obj) {
    switch (obj) {
      case SystemeJeu.systeme433:
        writer.writeByte(0);
        break;
      case SystemeJeu.systeme442:
        writer.writeByte(1);
        break;
      case SystemeJeu.systeme352:
        writer.writeByte(2);
        break;
      case SystemeJeu.systeme343:
        writer.writeByte(3);
        break;
      case SystemeJeu.systeme4231:
        writer.writeByte(4);
        break;
      case SystemeJeu.systeme4321:
        writer.writeByte(5);
        break;
      case SystemeJeu.systeme532:
        writer.writeByte(6);
        break;
      case SystemeJeu.systeme541:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemeJeuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
