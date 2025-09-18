import 'package:hive/hive.dart';
import 'joueur.dart';

part 'agent.g.dart';

@HiveType(typeId: 22)
class Agent extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nom;

  @HiveField(2)
  String prenom;

  @HiveField(3)
  String agence;

  @HiveField(4)
  String licence;

  @HiveField(5)
  double commission;

  @HiveField(6)
  List<Joueur> clients;

  @HiveField(7)
  int experience;

  @HiveField(8)
  int reputation;

  Agent({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.agence,
    required this.licence,
    required this.commission,
    required this.clients,
    required this.experience,
    required this.reputation,
  });
}
