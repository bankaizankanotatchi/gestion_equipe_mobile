import 'package:hive/hive.dart';

part 'style_gardien.g.dart';

@HiveType(typeId: 108)
enum StyleGardien {
  @HiveField(0) reflexe,
  @HiveField(1) anticipation,
  @HiveField(2) libero,
  @HiveField(3) classique,
}
