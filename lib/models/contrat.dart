import 'package:hive/hive.dart';
import 'prime.dart';
import 'clause.dart';

part 'contrat.g.dart';

@HiveType(typeId: 15)
class Contrat extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime dateDebut;

  @HiveField(2)
  DateTime dateFin;

  @HiveField(3)
  double salaireBrut;

  @HiveField(4)
  List<Prime> primes;

  @HiveField(5)
  List<Clause> clauses;

  @HiveField(6)
  List<String> assurances;

  @HiveField(7)
  List<String> avantages;

  @HiveField(8)
  bool prolongeable;

  @HiveField(9)
  bool resiliable;

  Contrat({
    required this.id,
    required this.dateDebut,
    required this.dateFin,
    required this.salaireBrut,
    required this.primes,
    required this.clauses,
    required this.assurances,
    required this.avantages,
    required this.prolongeable,
    required this.resiliable,
  });
}
