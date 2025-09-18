import 'package:hive/hive.dart';
import 'exercice.dart';
import 'joueur.dart';
import 'enums/type_entrainement.dart';
import 'enums/niveau_intensite.dart';
import 'enums/conditions_meteo.dart';

part 'entrainement.g.dart';

@HiveType(typeId: 27)
class Entrainement extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime dateEntrainement;

  @HiveField(2)
  int duree;

  @HiveField(3)
  TypeEntrainement type;

  @HiveField(4)
  NiveauIntensite intensite;

  @HiveField(5)
  List<String> objectifs;

  @HiveField(6)
  List<Exercice> exercices;

  @HiveField(7)
  List<Joueur> participantsPresents;

  @HiveField(8)
  List<Joueur> participantsAbsents;

  @HiveField(9)
  ConditionsMeteo conditions;

  Entrainement({
    required this.id,
    required this.dateEntrainement,
    required this.duree,
    required this.type,
    required this.intensite,
    required this.objectifs,
    required this.exercices,
    required this.participantsPresents,
    required this.participantsAbsents,
    required this.conditions,
  });
}
