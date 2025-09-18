import 'package:hive/hive.dart';

part 'couleur_carton.g.dart';

@HiveType(typeId: 113)
enum CouleurCarton {
  @HiveField(0) jaune,
  @HiveField(1) rouge,
}
