import 'package:hive/hive.dart';

part 'niveau_intensite.g.dart';

@HiveType(typeId: 126)
enum NiveauIntensite {
  @HiveField(0) faible,
  @HiveField(1) moyen,
  @HiveField(2) eleve,
}
