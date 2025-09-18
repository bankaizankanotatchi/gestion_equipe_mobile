import 'package:hive/hive.dart';

part 'suivi_blessure.g.dart';

@HiveType(typeId: 12)
class SuiviBlessure extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime dateVisite;

  @HiveField(2)
  String evolution;

  @HiveField(3)
  int douleur;

  @HiveField(4)
  int mobilite;

  @HiveField(5)
  String recommandations;

  @HiveField(6)
  DateTime prochainRendezVous;

  SuiviBlessure({
    required this.id,
    required this.dateVisite,
    required this.evolution,
    required this.douleur,
    required this.mobilite,
    required this.recommandations,
    required this.prochainRendezVous,
  });
}
