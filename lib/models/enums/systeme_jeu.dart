import 'package:hive/hive.dart';

part 'systeme_jeu.g.dart';

@HiveType(typeId: 104)
enum SystemeJeu {
  @HiveField(0) systeme433,
  @HiveField(1) systeme442,
  @HiveField(2) systeme352,
  @HiveField(3) systeme343,
  @HiveField(4) systeme4231,
  @HiveField(5) systeme4321,
  @HiveField(6) systeme532,
  @HiveField(7) systeme541,
}
