import 'package:hive/hive.dart';

// part 'personne.g.dart';

// @HiveType(typeId: 0) 
abstract class Personne extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nom;

  @HiveField(2)
  String prenom;

  @HiveField(3)
  DateTime dateNaissance;

  @HiveField(4)
  String telephone;

  @HiveField(5)
  String email;

  @HiveField(6)
  String adresse;

  @HiveField(7)
  String nationalite;

  @HiveField(8)
  String numeroPasseport;

  @HiveField(9)
  String numeroIdentite;

  Personne({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.dateNaissance,
    required this.telephone,
    required this.email,
    required this.adresse,
    required this.nationalite,
    required this.numeroPasseport,
    required this.numeroIdentite,
  });
}