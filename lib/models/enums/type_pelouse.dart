import 'package:hive/hive.dart';

part 'type_pelouse.g.dart';

@HiveType(typeId: 119)
enum TypePelouse {
  @HiveField(0) naturelle,
  @HiveField(1) synthetique,
  @HiveField(2) hybride,
}
