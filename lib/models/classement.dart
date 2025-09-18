import 'package:hive/hive.dart';
import 'position_classement.dart';

part 'classement.g.dart';

@HiveType(typeId: 24)
class Classement extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String saison;

  @HiveField(2)
  List<PositionClassement> positions;

  @HiveField(3)
  DateTime derniereMiseAJour;

  Classement({
    required this.id,
    required this.saison,
    required this.positions,
    required this.derniereMiseAJour,
  });
}
