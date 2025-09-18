// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgentAdapter extends TypeAdapter<Agent> {
  @override
  final int typeId = 22;

  @override
  Agent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Agent(
      id: fields[0] as int,
      nom: fields[1] as String,
      prenom: fields[2] as String,
      agence: fields[3] as String,
      licence: fields[4] as String,
      commission: fields[5] as double,
      clients: (fields[6] as List).cast<Joueur>(),
      experience: fields[7] as int,
      reputation: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Agent obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.prenom)
      ..writeByte(3)
      ..write(obj.agence)
      ..writeByte(4)
      ..write(obj.licence)
      ..writeByte(5)
      ..write(obj.commission)
      ..writeByte(6)
      ..write(obj.clients)
      ..writeByte(7)
      ..write(obj.experience)
      ..writeByte(8)
      ..write(obj.reputation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
