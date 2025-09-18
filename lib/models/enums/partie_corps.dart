import 'package:hive/hive.dart';

part 'partie_corps.g.dart';

@HiveType(typeId: 112)
enum PartieCorps {
  @HiveField(0) tete,
  @HiveField(1) piedGauche,
  @HiveField(2) piedDroit,
  @HiveField(3) poitrine,
  @HiveField(4) autre,
}
