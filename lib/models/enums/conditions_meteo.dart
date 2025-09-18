import 'package:hive/hive.dart';

part 'conditions_meteo.g.dart';

@HiveType(typeId: 110)
enum ConditionsMeteo {
  @HiveField(0) ensoleille,
  @HiveField(1) pluie,
  @HiveField(2) neige,
  @HiveField(3) vent,
  @HiveField(4) couvert,
}
