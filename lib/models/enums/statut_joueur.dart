import 'package:hive/hive.dart';

part 'statut_joueur.g.dart';

@HiveType(typeId: 101)
enum StatutJoueur {
  @HiveField(0) actif,
  @HiveField(1) blesse,
  @HiveField(2) suspendu,
  @HiveField(3) pret,
  @HiveField(4) reserve,
  @HiveField(5) international,
  @HiveField(6) retraite,
  @HiveField(7) transfertCours,
}
