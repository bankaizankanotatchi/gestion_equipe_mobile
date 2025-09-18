import 'package:hive/hive.dart';

part 'type_transfert.g.dart';

@HiveType(typeId: 122)
enum TypeTransfert {
  @HiveField(0) achat,
  @HiveField(1) pret,
  @HiveField(2) libre,
  @HiveField(3) echange,
}
