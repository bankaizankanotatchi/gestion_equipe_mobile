import 'package:hive/hive.dart';

part 'type_competition.g.dart';

@HiveType(typeId: 105)
enum TypeCompetition {
  @HiveField(0) championnat,
  @HiveField(1) coupeNationale,
  @HiveField(2) coupeEuropeenne,
  @HiveField(3) coupeMonde,
  @HiveField(4) matchAmical,
  @HiveField(5) tournoi,
  @HiveField(6) qualification,
}
