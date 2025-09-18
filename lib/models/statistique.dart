import 'package:hive/hive.dart';

part 'statistique.g.dart';

@HiveType(typeId: 14)
class Statistique extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String saison;

  @HiveField(2)
  int minutesJouees;

  @HiveField(3)
  int matchsJoues;

  @HiveField(4)
  int matchsTitulaire;

  @HiveField(5)
  int matchsRemplacant;

  @HiveField(6)
  int buts;

  @HiveField(7)
  int passesDecisives;

  @HiveField(8)
  int passesReussies;

  @HiveField(9)
  int passesTentees;

  @HiveField(10)
  int cartonsJaunes;

  @HiveField(11)
  int cartonsRouges;

  @HiveField(12)
  int tirs;

  @HiveField(13)
  int tirsCarres;

  @HiveField(14)
  double distance;

  @HiveField(15)
  double vitesseMoyenne;

  @HiveField(16)
  double precision;

  @HiveField(17)
  double notesMoyennes;

  @HiveField(18)
  int butsEncaisses;

  @HiveField(19)
  int arretsGardien;

  @HiveField(20)
  int penaltiesMarques;

  @HiveField(21)
  int penaltiesRates;

  @HiveField(22)
  int interceptions;

  @HiveField(23)
  int tacles;

  @HiveField(24)
  int fautes;

  @HiveField(25)
  int horsjeu;

  Statistique({
    required this.id,
    required this.saison,
    required this.minutesJouees,
    required this.matchsJoues,
    required this.matchsTitulaire,
    required this.matchsRemplacant,
    required this.buts,
    required this.passesDecisives,
    required this.passesReussies,
    required this.passesTentees,
    required this.cartonsJaunes,
    required this.cartonsRouges,
    required this.tirs,
    required this.tirsCarres,
    required this.distance,
    required this.vitesseMoyenne,
    required this.precision,
    required this.notesMoyennes,
    required this.butsEncaisses,
    required this.arretsGardien,
    required this.penaltiesMarques,
    required this.penaltiesRates,
    required this.interceptions,
    required this.tacles,
    required this.fautes,
    required this.horsjeu,
  });
}
