// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conditions_meteo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConditionsMeteoAdapter extends TypeAdapter<ConditionsMeteo> {
  @override
  final int typeId = 110;

  @override
  ConditionsMeteo read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ConditionsMeteo.ensoleille;
      case 1:
        return ConditionsMeteo.pluie;
      case 2:
        return ConditionsMeteo.neige;
      case 3:
        return ConditionsMeteo.vent;
      case 4:
        return ConditionsMeteo.couvert;
      default:
        return ConditionsMeteo.ensoleille;
    }
  }

  @override
  void write(BinaryWriter writer, ConditionsMeteo obj) {
    switch (obj) {
      case ConditionsMeteo.ensoleille:
        writer.writeByte(0);
        break;
      case ConditionsMeteo.pluie:
        writer.writeByte(1);
        break;
      case ConditionsMeteo.neige:
        writer.writeByte(2);
        break;
      case ConditionsMeteo.vent:
        writer.writeByte(3);
        break;
      case ConditionsMeteo.couvert:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConditionsMeteoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
