import 'package:hive/hive.dart';
import 'enums/type_evenement.dart';
import 'enums/periode_match.dart';
import 'enums/niveau_importance.dart';

part 'evenement_match.g.dart';

@HiveType(typeId: 11)
class EvenementMatch extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int minute;

  @HiveField(2)
  TypeEvenement type;

  @HiveField(3)
  String description;

  @HiveField(4)
  PeriodeMatch periode;

  @HiveField(5)
  NiveauImportance importance;

  @HiveField(6)
  bool visible;

  EvenementMatch({
    required this.id,
    required this.minute,
    required this.type,
    required this.description,
    required this.periode,
    required this.importance,
    required this.visible,
  });
}
