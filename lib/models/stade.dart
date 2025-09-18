import 'package:hive/hive.dart';
import 'enums/type_pelouse.dart';

part 'stade.g.dart';

@HiveType(typeId: 21)
class Stade extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nom;

  @HiveField(2)
  String ville;

  @HiveField(3)
  int capacite;

  @HiveField(4)
  int capaciteVIP;

  @HiveField(5)
  TypePelouse typePelouse;

  @HiveField(6)
  String dimensions;

  @HiveField(7)
  double longueur;

  @HiveField(8)
  double largeur;

  @HiveField(9)
  String adresse;

  @HiveField(10)
  DateTime dateConstruction;

  @HiveField(11)
  DateTime dateRenovation;

  @HiveField(12)
  List<String> equipements;

  @HiveField(13)
  int parking;

  @HiveField(14)
  bool accessibilite;

  @HiveField(15)
  String certification;

  Stade({
    required this.id,
    required this.nom,
    required this.ville,
    required this.capacite,
    required this.capaciteVIP,
    required this.typePelouse,
    required this.dimensions,
    required this.longueur,
    required this.largeur,
    required this.adresse,
    required this.dateConstruction,
    required this.dateRenovation,
    required this.equipements,
    required this.parking,
    required this.accessibilite,
    required this.certification,
  });
}
