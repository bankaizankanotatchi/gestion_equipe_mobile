import 'package:hive/hive.dart';
import 'joueur.dart';
import 'enums/systeme_jeu.dart';

part 'composition.g.dart';

@HiveType(typeId: 10)
class Composition extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  SystemeJeu systemeJeu;

  @HiveField(2)
  DateTime dateComposition;

  @HiveField(3)
  List<Joueur> titulaires;

  @HiveField(4)
  List<Joueur> remplacants;

  @HiveField(5)
  Joueur capitaine;

  @HiveField(6)
  List<Joueur> tireursPenalty;

  @HiveField(7)
  List<Joueur> tireursCoups;

  @HiveField(8)
  bool validee;

  Composition({
    required this.id,
    required this.systemeJeu,
    required this.dateComposition,
    required this.titulaires,
    required this.remplacants,
    required this.capitaine,
    required this.tireursPenalty,
    required this.tireursCoups,
    required this.validee,
  });
}
