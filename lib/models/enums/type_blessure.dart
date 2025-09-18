import 'package:hive/hive.dart';

part 'type_blessure.g.dart';

@HiveType(typeId: 116)
enum TypeBlessure {
  @HiveField(0) musculaire,
  @HiveField(1) ligamentaire,
  @HiveField(2) fracture,
  @HiveField(3) commotion,
  @HiveField(4) autre,
}
