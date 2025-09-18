// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impact_carriere.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImpactCarriereAdapter extends TypeAdapter<ImpactCarriere> {
  @override
  final int typeId = 118;

  @override
  ImpactCarriere read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ImpactCarriere.aucun;
      case 1:
        return ImpactCarriere.temporaire;
      case 2:
        return ImpactCarriere.longTerme;
      case 3:
        return ImpactCarriere.finCarriere;
      default:
        return ImpactCarriere.aucun;
    }
  }

  @override
  void write(BinaryWriter writer, ImpactCarriere obj) {
    switch (obj) {
      case ImpactCarriere.aucun:
        writer.writeByte(0);
        break;
      case ImpactCarriere.temporaire:
        writer.writeByte(1);
        break;
      case ImpactCarriere.longTerme:
        writer.writeByte(2);
        break;
      case ImpactCarriere.finCarriere:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImpactCarriereAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
