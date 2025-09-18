import 'package:hive/hive.dart';

part 'niveau_licence.g.dart';

@HiveType(typeId: 106)
enum NiveauLicence {
  @HiveField(0) debutant,
  @HiveField(1) intermediaire,
  @HiveField(2) avance,
  @HiveField(3) pro,
}
