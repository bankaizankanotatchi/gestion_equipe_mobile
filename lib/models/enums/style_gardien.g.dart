// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_gardien.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StyleGardienAdapter extends TypeAdapter<StyleGardien> {
  @override
  final int typeId = 108;

  @override
  StyleGardien read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StyleGardien.reflexe;
      case 1:
        return StyleGardien.anticipation;
      case 2:
        return StyleGardien.libero;
      case 3:
        return StyleGardien.classique;
      default:
        return StyleGardien.reflexe;
    }
  }

  @override
  void write(BinaryWriter writer, StyleGardien obj) {
    switch (obj) {
      case StyleGardien.reflexe:
        writer.writeByte(0);
        break;
      case StyleGardien.anticipation:
        writer.writeByte(1);
        break;
      case StyleGardien.libero:
        writer.writeByte(2);
        break;
      case StyleGardien.classique:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StyleGardienAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
