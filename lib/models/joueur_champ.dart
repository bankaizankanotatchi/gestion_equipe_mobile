import 'package:hive/hive.dart';
import 'package:team_manager_app/models/enums/pied_fort.dart';
import 'package:team_manager_app/models/enums/poste_joueur.dart';
import 'package:team_manager_app/models/enums/statut_joueur.dart';
import 'joueur.dart';

part 'joueur_champ.g.dart';

@HiveType(typeId: 3)
class JoueurChamp extends Joueur {
  @HiveField(25)
  int vitesse;

  @HiveField(26)
  int endurance;

  @HiveField(27)
  int technique;

  @HiveField(28)
  int physique;

  @HiveField(29)
  int mental;

  @HiveField(30)
  int tactique;

  @HiveField(31)
  int precision;

  @HiveField(32)
  int puissance;

  JoueurChamp({
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
    required int numeroMaillot,
    required PosteJoueur poste,
    required List<PosteJoueur> postesSecondaires,
    required PiedFort piedFort,
    required double taille,
    required double poids,
    required double salaire,
    required DateTime dateContrat,
    required DateTime finContrat,
    required StatutJoueur statut,
    required bool blessure,
    required bool suspension,
    required double valeurMarchande,
    required String formationInitiale,
    required List<String> languesParlees,
    required this.vitesse,
    required this.endurance,
    required this.technique,
    required this.physique,
    required this.mental,
    required this.tactique,
    required this.precision,
    required this.puissance,
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
          numeroMaillot: numeroMaillot,
          poste: poste,
          postesSecondaires: postesSecondaires,
          piedFort: piedFort,
          taille: taille,
          poids: poids,
          salaire: salaire,
          dateContrat: dateContrat,
          finContrat: finContrat,
          statut: statut,
          blessure: blessure,
          suspension: suspension,
          valeurMarchande: valeurMarchande,
          formationInitiale: formationInitiale,
          languesParlees: languesParlees,
        );
}
