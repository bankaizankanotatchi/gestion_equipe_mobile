// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_clause.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeClauseAdapter extends TypeAdapter<TypeClause> {
  @override
  final int typeId = 124;

  @override
  TypeClause read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeClause.liberatoire;
      case 1:
        return TypeClause.confidentialite;
      case 2:
        return TypeClause.performance;
      case 3:
        return TypeClause.autre;
      default:
        return TypeClause.liberatoire;
    }
  }

  @override
  void write(BinaryWriter writer, TypeClause obj) {
    switch (obj) {
      case TypeClause.liberatoire:
        writer.writeByte(0);
        break;
      case TypeClause.confidentialite:
        writer.writeByte(1);
        break;
      case TypeClause.performance:
        writer.writeByte(2);
        break;
      case TypeClause.autre:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeClauseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
