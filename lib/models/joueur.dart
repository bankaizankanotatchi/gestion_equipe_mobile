import 'package:hive/hive.dart';
import 'personne.dart';
import 'enums/poste_joueur.dart';
import 'enums/statut_joueur.dart';
import 'enums/pied_fort.dart';

part 'joueur.g.dart';

@HiveType(typeId: 1)
class Joueur extends Personne {
  @HiveField(10)
  int numeroMaillot;

  @HiveField(11)
  PosteJoueur poste;

  @HiveField(12)
  List<PosteJoueur> postesSecondaires;

  @HiveField(13)
  PiedFort piedFort;

  @HiveField(14)
  double taille;

  @HiveField(15)
  double poids;

  @HiveField(16)
  double salaire;

  @HiveField(17)
  DateTime dateContrat;

  @HiveField(18)
  DateTime finContrat;

  @HiveField(19)
  StatutJoueur statut;

  @HiveField(20)
  bool blessure;

  @HiveField(21)
  bool suspension;

  @HiveField(22)
  double valeurMarchande;

  @HiveField(23)
  String formationInitiale;

  @HiveField(24)
  List<String> languesParlees;

  Joueur({
    required int id,
    required String nom,
    required String prenom,
    required DateTime dateNaissance,
    required String telephone,
    required String email,
    required String adresse,
    required String nationalite,
    required String numeroPasseport,
    required String numeroIdentite,
    required this.numeroMaillot,
    required this.poste,
    required this.postesSecondaires,
    required this.piedFort,
    required this.taille,
    required this.poids,
    required this.salaire,
    required this.dateContrat,
    required this.finContrat,
    required this.statut,
    required this.blessure,
    required this.suspension,
    required this.valeurMarchande,
    required this.formationInitiale,
    required this.languesParlees,
  }) : super(
          id: id,
          nom: nom,
          prenom: prenom,
          dateNaissance: dateNaissance,
          telephone: telephone,
          email: email,
          adresse: adresse,
          nationalite: nationalite,
          numeroPasseport: numeroPasseport,
          numeroIdentite: numeroIdentite,
        );
}
