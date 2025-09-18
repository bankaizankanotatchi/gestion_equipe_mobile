import 'package:hive/hive.dart';

part 'impact_carton.g.dart';

@HiveType(typeId: 114)
enum ImpactCarton {
  @HiveField(0) faible,
  @HiveField(1) moyen,
  @HiveField(2) fort,
}
