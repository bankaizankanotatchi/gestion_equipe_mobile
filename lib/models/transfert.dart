import 'package:hive/hive.dart';
import 'contrat.dart';
import 'agent.dart';

part 'transfert.g.dart';

@HiveType(typeId: 16)
class Transfert extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  double montant;

  @HiveField(2)
  DateTime dateTransfert;

  @HiveField(3)
  String typeTransfert;

  @HiveField(4)
  int dureeContrat;

  @HiveField(5)
  double commission;

  @HiveField(6)
  double clauseLiberation;

  @HiveField(7)
  Agent agent;

  @HiveField(8)
  Contrat contrat;

  @HiveField(9)
  String conditionsSpeciales;

  Transfert({
    required this.id,
    required this.montant,
    required this.dateTransfert,
    required this.typeTransfert,
    required this.dureeContrat,
    required this.commission,
    required this.clauseLiberation,
    required this.agent,
    required this.contrat,
    required this.conditionsSpeciales,
  });
}
