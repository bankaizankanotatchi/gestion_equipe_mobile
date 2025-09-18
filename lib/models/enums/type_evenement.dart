import 'package:hive/hive.dart';

part 'type_evenement.g.dart';

@HiveType(typeId: 102)
enum TypeEvenement {
  @HiveField(0) but,
  @HiveField(1) cartonJaune,
  @HiveField(2) cartonRouge,
  @HiveField(3) remplacement,
  @HiveField(4) penalty,
  @HiveField(5) penaltyRate,
  @HiveField(6) arretJeu,
  @HiveField(7) horsJeu,
  @HiveField(8) faute,
  @HiveField(9) corner,
  @HiveField(10) touche,
  @HiveField(11) arretGardien,
  @HiveField(12) parade,
}
