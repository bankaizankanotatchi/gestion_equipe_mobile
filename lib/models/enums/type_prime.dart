import 'package:hive/hive.dart';

part 'type_prime.g.dart';

@HiveType(typeId: 123)
enum TypePrime {
  @HiveField(0) match,
  @HiveField(1) but,
  @HiveField(2) victoire,
  @HiveField(3) titre,
  @HiveField(4) autre,
}
