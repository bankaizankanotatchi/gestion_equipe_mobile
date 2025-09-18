// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistique.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatistiqueAdapter extends TypeAdapter<Statistique> {
  @override
  final int typeId = 14;

  @override
  Statistique read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Statistique(
      id: fields[0] as int,
      saison: fields[1] as String,
      minutesJouees: fields[2] as int,
      matchsJoues: fields[3] as int,
      matchsTitulaire: fields[4] as int,
      matchsRemplacant: fields[5] as int,
      buts: fields[6] as int,
      passesDecisives: fields[7] as int,
      passesReussies: fields[8] as int,
      passesTentees: fields[9] as int,
      cartonsJaunes: fields[10] as int,
      cartonsRouges: fields[11] as int,
      tirs: fields[12] as int,
      tirsCarres: fields[13] as int,
      distance: fields[14] as double,
      vitesseMoyenne: fields[15] as double,
      precision: fields[16] as double,
      notesMoyennes: fields[17] as double,
      butsEncaisses: fields[18] as int,
      arretsGardien: fields[19] as int,
      penaltiesMarques: fields[20] as int,
      penaltiesRates: fields[21] as int,
      interceptions: fields[22] as int,
      tacles: fields[23] as int,
      fautes: fields[24] as int,
      horsjeu: fields[25] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Statistique obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.saison)
      ..writeByte(2)
      ..write(obj.minutesJouees)
      ..writeByte(3)
      ..write(obj.matchsJoues)
      ..writeByte(4)
      ..write(obj.matchsTitulaire)
      ..writeByte(5)
      ..write(obj.matchsRemplacant)
      ..writeByte(6)
      ..write(obj.buts)
      ..writeByte(7)
      ..write(obj.passesDecisives)
      ..writeByte(8)
      ..write(obj.passesReussies)
      ..writeByte(9)
      ..write(obj.passesTentees)
      ..writeByte(10)
      ..write(obj.cartonsJaunes)
      ..writeByte(11)
      ..write(obj.cartonsRouges)
      ..writeByte(12)
      ..write(obj.tirs)
      ..writeByte(13)
      ..write(obj.tirsCarres)
      ..writeByte(14)
      ..write(obj.distance)
      ..writeByte(15)
      ..write(obj.vitesseMoyenne)
      ..writeByte(16)
      ..write(obj.precision)
      ..writeByte(17)
      ..write(obj.notesMoyennes)
      ..writeByte(18)
      ..write(obj.butsEncaisses)
      ..writeByte(19)
      ..write(obj.arretsGardien)
      ..writeByte(20)
      ..write(obj.penaltiesMarques)
      ..writeByte(21)
      ..write(obj.penaltiesRates)
      ..writeByte(22)
      ..write(obj.interceptions)
      ..writeByte(23)
      ..write(obj.tacles)
      ..writeByte(24)
      ..write(obj.fautes)
      ..writeByte(25)
      ..write(obj.horsjeu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatistiqueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
