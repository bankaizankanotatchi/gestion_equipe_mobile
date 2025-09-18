import 'package:hive/hive.dart';
import 'suivi_blessure.dart';
import 'enums/type_blessure.dart';
import 'enums/gravite_blessure.dart';
import 'enums/impact_carriere.dart';

part 'blessure.g.dart';

@HiveType(typeId: 13)
class Blessure extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  TypeBlessure type;

  @HiveField(2)
  GraviteBlessure gravite;

  @HiveField(3)
  DateTime dateBlessure;

  @HiveField(4)
  int dureeEstimee;

  @HiveField(5)
  int dureeReelle;

  @HiveField(6)
  String description;

  @HiveField(7)
  bool soigne;

  @HiveField(8)
  DateTime dateRetour;

  @HiveField(9)
  String circumstancesBlessure;

  @HiveField(10)
  String traitement;

  @HiveField(11)
  List<SuiviBlessure> suivi;

  @HiveField(12)
  bool recidive;

  @HiveField(13)
  ImpactCarriere impactCarriere;

  Blessure({
    required this.id,
    required this.type,
    required this.gravite,
    required this.dateBlessure,
    required this.dureeEstimee,
    required this.dureeReelle,
    required this.description,
    required this.soigne,
    required this.dateRetour,
    required this.circumstancesBlessure,
    required this.traitement,
    required this.suivi,
    required this.recidive,
    required this.impactCarriere,
  });
}
