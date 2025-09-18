import 'package:hive/hive.dart';

part 'impact_carriere.g.dart';

@HiveType(typeId: 118)
enum ImpactCarriere {
  @HiveField(0) aucun,
  @HiveField(1) temporaire,
  @HiveField(2) longTerme,
  @HiveField(3) finCarriere,
}
