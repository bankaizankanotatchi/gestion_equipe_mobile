import 'package:hive/hive.dart';

part 'poste_joueur.g.dart';

@HiveType(typeId: 100)
enum PosteJoueur {
  @HiveField(0)
  gardien,

  @HiveField(1)
  defenseurCentral,

  @HiveField(2)
  defenseurLateralDroit,

  @HiveField(3)
  defenseurLateralGauche,

  @HiveField(4)
  milieuDefensif,

  @HiveField(5)
  milieuCentral,

  @HiveField(6)
  milieuOffensif,

  @HiveField(7)
  milieuRelayeur,

  @HiveField(8)
  ailierDroit,

  @HiveField(9)
  ailierGauche,

  @HiveField(10)
  secondAttaquant,

  @HiveField(11)
  attaquantCentre,

  @HiveField(12)
  fauxNeuf,
}
