import 'package:hive/hive.dart';

part 'palmares.g.dart';

@HiveType(typeId: 19)
class Palmares extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String competition;

  @HiveField(2)
  String saison;

  @HiveField(3)
  int position;

  @HiveField(4)
  DateTime dateObtention;

  @HiveField(5)
  String titre;

  @HiveField(6)
  int importance;

  Palmares({
    required this.id,
    required this.competition,
    required this.saison,
    required this.position,
    required this.dateObtention,
    required this.titre,
    required this.importance,
  });
}
