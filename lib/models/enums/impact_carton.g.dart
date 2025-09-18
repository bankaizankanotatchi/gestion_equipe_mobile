// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impact_carton.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImpactCartonAdapter extends TypeAdapter<ImpactCarton> {
  @override
  final int typeId = 114;

  @override
  ImpactCarton read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ImpactCarton.faible;
      case 1:
        return ImpactCarton.moyen;
      case 2:
        return ImpactCarton.fort;
      default:
        return ImpactCarton.faible;
    }
  }

  @override
  void write(BinaryWriter writer, ImpactCarton obj) {
    switch (obj) {
      case ImpactCarton.faible:
        writer.writeByte(0);
        break;
      case ImpactCarton.moyen:
        writer.writeByte(1);
        break;
      case ImpactCarton.fort:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImpactCartonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
