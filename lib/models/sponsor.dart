import 'package:hive/hive.dart';

part 'sponsor.g.dart';

@HiveType(typeId: 20)
class Sponsor extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nom;

  @HiveField(2)
  String secteurActivite;

  @HiveField(3)
  double montantSponsoring;

  @HiveField(4)
  int dureeContrat;

  @HiveField(5)
  List<String> visibilite;

  @HiveField(6)
  List<String> droitsCommercials;

  @HiveField(7)
  List<String> activations;

  Sponsor({
    required this.id,
    required this.nom,
    required this.secteurActivite,
    required this.montantSponsoring,
    required this.dureeContrat,
    required this.visibilite,
    required this.droitsCommercials,
    required this.activations,
  });
}
