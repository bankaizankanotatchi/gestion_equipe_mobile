import 'package:hive/hive.dart';
import 'joueur.dart';
import 'staff.dart';
import 'stade.dart';
import 'sponsor.dart';
import 'palmares.dart';

part 'equipe.g.dart';

@HiveType(typeId: 8)
class Equipe extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nom;

  @HiveField(2)
  String nomCourt;

  @HiveField(3)
  String ville;

  @HiveField(4)
  String couleurPrincipale;

  @HiveField(5)
  String couleurSecondaire;

  @HiveField(6)
  DateTime dateCreation;

  @HiveField(7)
  double budget;

  @HiveField(8)
  double massesSalariales;

  @HiveField(9)
  String logo;

  @HiveField(10)
  String hymne;

  @HiveField(11)
  String president;

  @HiveField(12)
  String directeurSportif;

  @HiveField(13)
  String centreEntrainement;

  @HiveField(14)
  int supporteurs;

  @HiveField(15)
  List<Palmares> palmares;

  @HiveField(16)
  List<Joueur> joueurs;

  @HiveField(17)
  List<Staff> staffs;

  @HiveField(18)
  Stade stade;

  @HiveField(19)
  List<Sponsor> sponsors;

  Equipe({
    required this.id,
    required this.nom,
    required this.nomCourt,
    required this.ville,
    required this.couleurPrincipale,
    required this.couleurSecondaire,
    required this.dateCreation,
    required this.budget,
    required this.massesSalariales,
    required this.logo,
    required this.hymne,
    required this.president,
    required this.directeurSportif,
    required this.centreEntrainement,
    required this.supporteurs,
    required this.palmares,
    required this.joueurs,
    required this.staffs,
    required this.stade,
    required this.sponsors,
  });
}
