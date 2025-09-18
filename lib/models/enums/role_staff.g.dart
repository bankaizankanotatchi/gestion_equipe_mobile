// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_staff.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoleStaffAdapter extends TypeAdapter<RoleStaff> {
  @override
  final int typeId = 107;

  @override
  RoleStaff read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RoleStaff.preparateurPhysique;
      case 1:
        return RoleStaff.medecin;
      case 2:
        return RoleStaff.analysteVideo;
      case 3:
        return RoleStaff.kine;
      case 4:
        return RoleStaff.autre;
      default:
        return RoleStaff.preparateurPhysique;
    }
  }

  @override
  void write(BinaryWriter writer, RoleStaff obj) {
    switch (obj) {
      case RoleStaff.preparateurPhysique:
        writer.writeByte(0);
        break;
      case RoleStaff.medecin:
        writer.writeByte(1);
        break;
      case RoleStaff.analysteVideo:
        writer.writeByte(2);
        break;
      case RoleStaff.kine:
        writer.writeByte(3);
        break;
      case RoleStaff.autre:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleStaffAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
