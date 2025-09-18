import 'package:hive/hive.dart';
import 'enums/type_clause.dart';

part 'clause.g.dart';

@HiveType(typeId: 18)
class Clause extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  TypeClause type;

  @HiveField(2)
  String description;

  @HiveField(3)
  double montant;

  @HiveField(4)
  String conditions;

  @HiveField(5)
  bool active;

  @HiveField(6)
  DateTime dateExpiration;

  Clause({
    required this.id,
    required this.type,
    required this.description,
    required this.montant,
    required this.conditions,
    required this.active,
    required this.dateExpiration,
  });
}
