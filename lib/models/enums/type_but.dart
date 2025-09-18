import 'package:hive/hive.dart';

part 'type_but.g.dart';

@HiveType(typeId: 111)
enum TypeBut {
  @HiveField(0) tir,
  @HiveField(1) tete,
  @HiveField(2) coupFranc,
  @HiveField(3) penalty,
  @HiveField(4) contreSonCamp,
}
