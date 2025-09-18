import 'package:hive/hive.dart';

part 'exercice.g.dart';

@HiveType(typeId: 26)
class Exercice extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nom;

  @HiveField(2)
  String description;

  @HiveField(3)
  int duree;

  @HiveField(4)
  List<String> materiel;

  @HiveField(5)
  List<String> competencesTrainees;

  @HiveField(6)
  int difficulte;

  Exercice({
    required this.id,
    required this.nom,
    required this.description,
    required this.duree,
    required this.materiel,
    required this.competencesTrainees,
    required this.difficulte,
  });
}
