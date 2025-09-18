import 'package:hive/hive.dart';
import 'package:team_manager_app/models/enums/pied_fort.dart';
import 'package:team_manager_app/models/enums/poste_joueur.dart';
import 'package:team_manager_app/models/enums/statut_joueur.dart';
import 'joueur.dart';
import 'enums/style_gardien.dart';

part 'gardien.g.dart';

@HiveType(typeId: 2)
class Gardien extends Joueur {
  @HiveField(25)
  int tailleGants;

  @HiveField(26)
  StyleGardien styleJeu;

  @HiveField(27)
  int arretsReflexes;

  @HiveField(28)
  int sortiesAeriennes;

  @HiveField(29)
  int relancePied;

  @HiveField(30)
  int relanceMains;

  @HiveField(31)
  int commandementSurface;

  @HiveField(32)
  int penaltiesArrets;

  Gardien({
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
    required this.tailleGants,
    required this.styleJeu,
    required this.arretsReflexes,
    required this.sortiesAeriennes,
    required this.relancePied,
    required this.relanceMains,
    required this.commandementSurface,
    required this.penaltiesArrets,
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
