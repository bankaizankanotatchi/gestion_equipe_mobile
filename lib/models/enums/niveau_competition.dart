import 'package:hive/hive.dart';

part 'niveau_competition.g.dart';

@HiveType(typeId: 120)
enum NiveauCompetition {
  @HiveField(0) local,
  @HiveField(1) national,
  @HiveField(2) continental,
  @HiveField(3) mondial,
}
