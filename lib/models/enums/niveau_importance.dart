import 'package:hive/hive.dart';

part 'niveau_importance.g.dart';

@HiveType(typeId: 127)
enum NiveauImportance {
  @HiveField(0) faible,
  @HiveField(1) moyen,
  @HiveField(2) eleve,
}
