// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contrat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContratAdapter extends TypeAdapter<Contrat> {
  @override
  final int typeId = 15;

  @override
  Contrat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contrat(
      id: fields[0] as int,
      dateDebut: fields[1] as DateTime,
      dateFin: fields[2] as DateTime,
      salaireBrut: fields[3] as double,
      primes: (fields[4] as List).cast<Prime>(),
      clauses: (fields[5] as List).cast<Clause>(),
      assurances: (fields[6] as List).cast<String>(),
      avantages: (fields[7] as List).cast<String>(),
      prolongeable: fields[8] as bool,
      resiliable: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Contrat obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateDebut)
      ..writeByte(2)
      ..write(obj.dateFin)
      ..writeByte(3)
      ..write(obj.salaireBrut)
      ..writeByte(4)
      ..write(obj.primes)
      ..writeByte(5)
      ..write(obj.clauses)
      ..writeByte(6)
      ..write(obj.assurances)
      ..writeByte(7)
      ..write(obj.avantages)
      ..writeByte(8)
      ..write(obj.prolongeable)
      ..writeByte(9)
      ..write(obj.resiliable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContratAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
