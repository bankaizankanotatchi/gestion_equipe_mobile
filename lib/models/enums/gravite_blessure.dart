import 'package:hive/hive.dart';

part 'gravite_blessure.g.dart';

@HiveType(typeId: 117)
enum GraviteBlessure {
  @HiveField(0) legere,
  @HiveField(1) moyenne,
  @HiveField(2) grave,
  @HiveField(3) critique,
}
