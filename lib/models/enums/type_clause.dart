import 'package:hive/hive.dart';

part 'type_clause.g.dart';

@HiveType(typeId: 124)
enum TypeClause {
  @HiveField(0) liberatoire,
  @HiveField(1) confidentialite,
  @HiveField(2) performance,
  @HiveField(3) autre,
}
