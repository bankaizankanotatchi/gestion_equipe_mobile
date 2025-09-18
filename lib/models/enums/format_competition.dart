import 'package:hive/hive.dart';

part 'format_competition.g.dart';

@HiveType(typeId: 121)
enum FormatCompetition {
  @HiveField(0) championnat,
  @HiveField(1) coupe,
  @HiveField(2) groupes,
  @HiveField(3) eliminationDirecte,
}
