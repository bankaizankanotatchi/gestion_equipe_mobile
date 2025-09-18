import 'package:hive/hive.dart';

part 'pied_fort.g.dart';

@HiveType(typeId: 109)
enum PiedFort {
  @HiveField(0) gauche,
  @HiveField(1) droit,
  @HiveField(2) lesDeux,
}
