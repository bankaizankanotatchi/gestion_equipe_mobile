import 'package:hive/hive.dart';

part 'statut_match.g.dart';

@HiveType(typeId: 103)
enum StatutMatch {
  @HiveField(0) programme,
  @HiveField(1) enCours,
  @HiveField(2) miTemps,
  @HiveField(3) termine,
  @HiveField(4) reporte,
  @HiveField(5) annule,
  @HiveField(6) forfait,
  @HiveField(7) prolongations,
  @HiveField(8) tirsAuBut,
}
