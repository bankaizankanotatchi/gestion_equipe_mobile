import 'package:hive/hive.dart';
import 'classement.dart';
import 'palmares.dart';
import 'enums/type_competition.dart';
import 'enums/niveau_competition.dart';
import 'enums/format_competition.dart';

part 'competition.g.dart';

@HiveType(typeId: 25)
class Competition extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nom;

  @HiveField(2)
  TypeCompetition type;

  @HiveField(3)
  NiveauCompetition niveau;

  @HiveField(4)
  String saison;

  @HiveField(5)
  DateTime dateDebut;

  @HiveField(6)
  DateTime dateFin;

  @HiveField(7)
  int nombreEquipes;

  @HiveField(8)
  FormatCompetition format;

  @HiveField(9)
  double dotation;

  @HiveField(10)
  String sponsor;

  @HiveField(11)
  String organisateur;

  @HiveField(12)
  String reglements;

  @HiveField(13)
  List<Palmares> palmares;

  @HiveField(14)
  Classement classement;

  Competition({
    required this.id,
    required this.nom,
    required this.type,
    required this.niveau,
    required this.saison,
    required this.dateDebut,
    required this.dateFin,
    required this.nombreEquipes,
    required this.format,
    required this.dotation,
    required this.sponsor,
    required this.organisateur,
    required this.reglements,
    required this.palmares,
    required this.classement,
  });
}
