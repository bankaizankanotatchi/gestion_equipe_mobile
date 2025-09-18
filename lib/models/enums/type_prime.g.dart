// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_prime.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypePrimeAdapter extends TypeAdapter<TypePrime> {
  @override
  final int typeId = 123;

  @override
  TypePrime read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypePrime.match;
      case 1:
        return TypePrime.but;
      case 2:
        return TypePrime.victoire;
      case 3:
        return TypePrime.titre;
      case 4:
        return TypePrime.autre;
      default:
        return TypePrime.match;
    }
  }

  @override
  void write(BinaryWriter writer, TypePrime obj) {
    switch (obj) {
      case TypePrime.match:
        writer.writeByte(0);
        break;
      case TypePrime.but:
        writer.writeByte(1);
        break;
      case TypePrime.victoire:
        writer.writeByte(2);
        break;
      case TypePrime.titre:
        writer.writeByte(3);
        break;
      case TypePrime.autre:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypePrimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
