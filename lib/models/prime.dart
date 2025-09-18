import 'package:hive/hive.dart';
import 'enums/type_prime.dart';

part 'prime.g.dart';

@HiveType(typeId: 17)
class Prime extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  TypePrime type;

  @HiveField(2)
  double montant;

  @HiveField(3)
  String condition;

  @HiveField(4)
  bool atteinte;

  Prime({
    required this.id,
    required this.type,
    required this.montant,
    required this.condition,
    required this.atteinte,
  });
}
