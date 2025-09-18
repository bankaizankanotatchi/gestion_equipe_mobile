import 'package:hive/hive.dart';

part 'periode_match.g.dart';

@HiveType(typeId: 115)
enum PeriodeMatch {
  @HiveField(0) premiereMiTemps,
  @HiveField(1) deuxiemeMiTemps,
  @HiveField(2) prolongation,
  @HiveField(3) tirsAuBut,
}
