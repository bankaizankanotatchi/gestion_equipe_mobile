import 'package:hive/hive.dart';

part 'type_entrainement.g.dart';

@HiveType(typeId: 125)
enum TypeEntrainement {
  @HiveField(0) physique,
  @HiveField(1) tactique,
  @HiveField(2) technique,
  @HiveField(3) mental,
  @HiveField(4) recuperation,
}
