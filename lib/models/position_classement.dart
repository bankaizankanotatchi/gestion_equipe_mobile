import 'package:hive/hive.dart';

part 'position_classement.g.dart';

@HiveType(typeId: 23)
class PositionClassement extends HiveObject {
  @HiveField(0)
  int position;

  @HiveField(1)
  int points;

  @HiveField(2)
  int matchsJoues;

  @HiveField(3)
  int victoires;

  @HiveField(4)
  int nuls;

  @HiveField(5)
  int defaites;

  @HiveField(6)
  int butsMarques;

  @HiveField(7)
  int butsEncaisses;

  @HiveField(8)
  int difference;

  PositionClassement({
    required this.position,
    required this.points,
    required this.matchsJoues,
    required this.victoires,
    required this.nuls,
    required this.defaites,
    required this.butsMarques,
    required this.butsEncaisses,
    required this.difference,
  });
}
