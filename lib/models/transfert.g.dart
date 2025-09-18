// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfert.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransfertAdapter extends TypeAdapter<Transfert> {
  @override
  final int typeId = 16;

  @override
  Transfert read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transfert(
      id: fields[0] as int,
      montant: fields[1] as double,
      dateTransfert: fields[2] as DateTime,
      typeTransfert: fields[3] as String,
      dureeContrat: fields[4] as int,
      commission: fields[5] as double,
      clauseLiberation: fields[6] as double,
      agent: fields[7] as Agent,
      contrat: fields[8] as Contrat,
      conditionsSpeciales: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Transfert obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.montant)
      ..writeByte(2)
      ..write(obj.dateTransfert)
      ..writeByte(3)
      ..write(obj.typeTransfert)
      ..writeByte(4)
      ..write(obj.dureeContrat)
      ..writeByte(5)
      ..write(obj.commission)
      ..writeByte(6)
      ..write(obj.clauseLiberation)
      ..writeByte(7)
      ..write(obj.agent)
      ..writeByte(8)
      ..write(obj.contrat)
      ..writeByte(9)
      ..write(obj.conditionsSpeciales);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransfertAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
