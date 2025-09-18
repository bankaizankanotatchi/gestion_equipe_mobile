import 'package:hive/hive.dart';

part 'role_staff.g.dart';

@HiveType(typeId: 107)
enum RoleStaff {
  @HiveField(0) preparateurPhysique,
  @HiveField(1) medecin,
  @HiveField(2) analysteVideo,
  @HiveField(3) kine,
  @HiveField(4) autre,
}
