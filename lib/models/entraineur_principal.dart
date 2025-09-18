import 'package:hive/hive.dart';
import 'package:team_manager_app/models/enums/niveau_licence.dart';
import 'package:team_manager_app/models/enums/systeme_jeu.dart';
import 'personne.dart';
import 'palmares.dart';

part 'entraineur_principal.g.dart';

@HiveType(typeId: 20)
class EntraineurPrincipal extends Personne {
  @HiveField(10)
  String licenceEntraineur;

  @HiveField(11)
  NiveauLicence niveauLicence;

  @HiveField(12)
  int experience;

  @HiveField(13)
  double salaire;

  @HiveField(14)
  String tactiqueFavorite;

  @HiveField(15)
  SystemeJeu systemeJeu;

  @HiveField(16)
  String philosophieJeu;

  @HiveField(17)
  List<Palmares> palmaresEntraineur;

  EntraineurPrincipal({
    required super.id,
    required super.nom,
    required super.prenom,
    required super.dateNaissance,
    required super.telephone,
    required super.email,
    required super.adresse,
    required super.nationalite,
    required super.numeroPasseport,
    required super.numeroIdentite,
    required this.licenceEntraineur,
    required this.niveauLicence,
    required this.experience,
    required this.salaire,
    required this.tactiqueFavorite,
    required this.systemeJeu,
    required this.philosophieJeu,
    required this.palmaresEntraineur,
  });
}
