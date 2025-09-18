// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partie_corps.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartieCorpsAdapter extends TypeAdapter<PartieCorps> {
  @override
  final int typeId = 112;

  @override
  PartieCorps read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PartieCorps.tete;
      case 1:
        return PartieCorps.piedGauche;
      case 2:
        return PartieCorps.piedDroit;
      case 3:
        return PartieCorps.poitrine;
      case 4:
        return PartieCorps.autre;
      default:
        return PartieCorps.tete;
    }
  }

  @override
  void write(BinaryWriter writer, PartieCorps obj) {
    switch (obj) {
      case PartieCorps.tete:
        writer.writeByte(0);
        break;
      case PartieCorps.piedGauche:
        writer.writeByte(1);
        break;
      case PartieCorps.piedDroit:
        writer.writeByte(2);
        break;
      case PartieCorps.poitrine:
        writer.writeByte(3);
        break;
      case PartieCorps.autre:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartieCorpsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
