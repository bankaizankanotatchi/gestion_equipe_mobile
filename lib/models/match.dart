import 'package:hive/hive.dart';
import 'equipe.dart';
import 'stade.dart';
import 'competition.dart';
import 'composition.dart';
import 'evenement_match.dart';
import 'enums/statut_match.dart';
import 'enums/conditions_meteo.dart';

part 'match.g.dart';

@HiveType(typeId: 9)
class Match extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime dateMatch;

  @HiveField(2)
  int journee;

  @HiveField(3)
  int scoreEquipeDomicile;

  @HiveField(4)
  int scoreEquipeExterieur;

  @HiveField(5)
  StatutMatch statut;

  @HiveField(6)
  String arbitrePrincipal;

  @HiveField(7)
  List<String> arbitresAssistants;

  @HiveField(8)
  String quatriemeArbitre;

  @HiveField(9)
  String vars;

  @HiveField(10)
  ConditionsMeteo conditions;

  @HiveField(11)
  double temperature;

  @HiveField(12)
  int spectateurs;

  @HiveField(13)
  double recettes;

  @HiveField(14)
  bool televise;

  @HiveField(15)
  String commentaires;

  @HiveField(16)
  Equipe equipeDomicile;

  @HiveField(17)
  Equipe equipeExterieur;

  @HiveField(18)
  Stade stade;

  @HiveField(19)
  Competition competition;

  @HiveField(20)
  Composition composition;

  @HiveField(21)
  List<EvenementMatch> evenements;

  Match({
    required this.id,
    required this.dateMatch,
    required this.journee,
    required this.scoreEquipeDomicile,
    required this.scoreEquipeExterieur,
    required this.statut,
    required this.arbitrePrincipal,
    required this.arbitresAssistants,
    required this.quatriemeArbitre,
    required this.vars,
    required this.conditions,
    required this.temperature,
    required this.spectateurs,
    required this.recettes,
    required this.televise,
    required this.commentaires,
    required this.equipeDomicile,
    required this.equipeExterieur,
    required this.stade,
    required this.competition,
    required this.composition,
    required this.evenements,
  });
}
