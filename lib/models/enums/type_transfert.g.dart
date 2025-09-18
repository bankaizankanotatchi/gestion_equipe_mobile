// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_transfert.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeTransfertAdapter extends TypeAdapter<TypeTransfert> {
  @override
  final int typeId = 122;

  @override
  TypeTransfert read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeTransfert.achat;
      case 1:
        return TypeTransfert.pret;
      case 2:
        return TypeTransfert.libre;
      case 3:
        return TypeTransfert.echange;
      default:
        return TypeTransfert.achat;
    }
  }

  @override
  void write(BinaryWriter writer, TypeTransfert obj) {
    switch (obj) {
      case TypeTransfert.achat:
        writer.writeByte(0);
        break;
      case TypeTransfert.pret:
        writer.writeByte(1);
        break;
      case TypeTransfert.libre:
        writer.writeByte(2);
        break;
      case TypeTransfert.echange:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeTransfertAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
