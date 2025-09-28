import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/enums/pied_fort.dart';
import 'package:team_manager_app/models/enums/poste_joueur.dart';
import 'package:team_manager_app/models/enums/role_staff.dart';
import 'package:team_manager_app/models/enums/statut_joueur.dart';
import 'package:team_manager_app/models/enums/type_pelouse.dart';
import 'package:team_manager_app/models/equipe.dart';
import 'package:team_manager_app/models/joueur.dart';
import 'package:team_manager_app/models/staff.dart';
import 'package:team_manager_app/models/stade.dart';
import 'package:team_manager_app/models/sponsor.dart';
import 'package:team_manager_app/models/palmares.dart';

void main() {
  setUpAll(() async {
    Hive.init('./hive_testing_path');

    Hive.registerAdapter(EquipeAdapter());
    Hive.registerAdapter(JoueurAdapter());
    Hive.registerAdapter(StaffAdapter());
    Hive.registerAdapter(StadeAdapter());
    Hive.registerAdapter(SponsorAdapter());
    Hive.registerAdapter(PalmaresAdapter());
    Hive.registerAdapter(PosteJoueurAdapter());
    Hive.registerAdapter(TypePelouseAdapter());
    Hive.registerAdapter(PiedFortAdapter());
    Hive.registerAdapter(StatutJoueurAdapter());
    Hive.registerAdapter(RoleStaffAdapter());
  });

  group('Equipe CRUD Tests', () {
    test('CREATE & READ Equipe', () async {
      final box = await Hive.openBox<Equipe>('equipeBoxTest');

      final palmares = Palmares(
        id: 1,
        titre: "Champion Ligue 1",
        dateObtention: DateTime.now(),
        competition: "Ligue 1",
        saison: '2024',
        position: 1,
        importance: 5,
      );

      final joueur = Joueur(
        id: 1,
        nom: 'Smith',
        prenom: 'Will',
        dateNaissance: DateTime(1998, 1, 15),
        telephone: '0700000000',
        email: 'will.smith@test.com',
        adresse: '456 rue test',
        nationalite: 'US',
        numeroPasseport: 'Y654321',
        numeroIdentite: '987654321',
        numeroMaillot: 7,
        poste: PosteJoueur.attaquantCentre,
        postesSecondaires: [],
        piedFort: PiedFort.gauche,
        taille: 1.85,
        poids: 78,
        salaire: 100000.0,
        dateContrat: DateTime(2021, 8, 1),
        finContrat: DateTime(2024, 7, 31),
        statut: StatutJoueur.actif,
        blessure: false,
        suspension: false,
        valeurMarchande: 2500000.0,
        formationInitiale: 'Académie US',
        languesParlees: ['Anglais'],
      );

      final staff = Staff(
        id: 1,
        nom: "Dupont",
        prenom: "Jean",
        role: RoleStaff.kine,
        dateNaissance: DateTime.now(),
        telephone: '',
        email: '',
        adresse: '',
        nationalite: '',
        numeroPasseport: '',
        numeroIdentite: '',
        specialite: '',
        certification: '',
        experience: 5,
      );

      final stade = Stade(
        id: 1,
        nom: "Parc des Princes",
        ville: "Paris",
        capacite: 48000,
        capaciteVIP: 20,
        typePelouse: TypePelouse.naturelle,
        dimensions: '',
        longueur: 20,
        largeur: 20,
        adresse: '',
        dateConstruction: DateTime.now(),
        dateRenovation: DateTime.now(),
        equipements: [],
        parking: 30,
        accessibilite: true,
        certification: '',
      );

      final sponsor = Sponsor(
        id: 1,
        nom: "Nike",
        dureeContrat: 5,
        secteurActivite: '',
        montantSponsoring: 20,
        visibilite: [],
        droitsCommercials: [],
        activations: [],
      );

      final equipe = Equipe(
        id: 1,
        nom: "Paris Saint-Germain",
        nomCourt: "PSG",
        ville: "Paris",
        couleurPrincipale: "Bleu",
        couleurSecondaire: "Rouge",
        dateCreation: DateTime(1970, 8, 12),
        budget: 300000000,
        massesSalariales: 200000000,
        logo: "psg_logo.png",
        hymne: "Allez Paris!",
        president: "Nasser Al-Khelaifi",
        directeurSportif: "Leonardo",
        centreEntrainement: "Camp des Loges",
        supporteurs: 50000,
        palmares: [palmares],
        joueurs: [joueur],
        staffs: [staff],
        stade: stade,
        sponsors: [sponsor],
      );

      await box.put('equipe1', equipe);

      final fromHive = box.get('equipe1');

      expect(fromHive, isNotNull);
      expect(fromHive!.nom, "Paris Saint-Germain");
      expect(fromHive.joueurs.length, 1);
      expect(fromHive.palmares.first.titre, "Champion Ligue 1");
      expect(fromHive.stade.nom, "Parc des Princes");

      await box.close();
    });

    test('UPDATE Equipe', () async {
      final box = await Hive.openBox<Equipe>('equipeBoxTest');

      final equipe = box.get('equipe1')!;
      equipe.budget = 350000000;
      equipe.supporteurs = 60000;

      await equipe.save();

      final updated = box.get('equipe1');

      expect(updated!.budget, 350000000);
      expect(updated.supporteurs, 60000);

      await box.close();
    });

    test('DELETE Equipe', () async {
      final box = await Hive.openBox<Equipe>('equipeBoxTest');

      await box.delete('equipe1');

      final deleted = box.get('equipe1');
      expect(deleted, isNull);

      await box.close();
    });
  });

  group('Equipe Edge Case Tests', () {
    test('Equipe avec listes vides', () async {
      final box = await Hive.openBox<Equipe>('equipeBoxTest');

      final stade = Stade(
        id: 2,
        nom: "Parc des Princes",
        ville: "Paris",
        capacite: 48000,
        capaciteVIP: 20,
        typePelouse: TypePelouse.naturelle,
        dimensions: '',
        longueur: 20,
        largeur: 20,
        adresse: '',
        dateConstruction: DateTime.now(),
        dateRenovation: DateTime.now(),
        equipements: [],
        parking: 30,
        accessibilite: true,
        certification: '',
      );

      final equipe = Equipe(
        id: 2,
        nom: "Equipe Vide",
        nomCourt: "",
        ville: "",
        couleurPrincipale: "",
        couleurSecondaire: "",
        dateCreation: DateTime.now(),
        budget: 0,
        massesSalariales: 0,
        logo: "",
        hymne: "",
        president: "",
        directeurSportif: "",
        centreEntrainement: "",
        supporteurs: 0,
        palmares: [],
        joueurs: [],
        staffs: [],
        stade: stade,
        sponsors: [],
      );

      await box.put('equipe2', equipe);

      final fromHive = box.get('equipe2');

      expect(fromHive!.joueurs.isEmpty, isTrue);
      expect(fromHive.palmares.isEmpty, isTrue);
      expect(fromHive.staffs.isEmpty, isTrue);

      await box.close();
    });

    test('Equipe avec dateCreation future', () async {
      final box = await Hive.openBox<Equipe>('equipeBoxTest');

      final stade = Stade(
        id: 3,
        nom: "Parc des Princes",
        ville: "Paris",
        capacite: 48000,
        capaciteVIP: 20,
        typePelouse: TypePelouse.naturelle,
        dimensions: '',
        longueur: 20,
        largeur: 20,
        adresse: '',
        dateConstruction: DateTime.now(),
        dateRenovation: DateTime.now(),
        equipements: [],
        parking: 30,
        accessibilite: true,
        certification: '',
      );

      final equipe = Equipe(
        id: 3,
        nom: "Futur FC",
        nomCourt: "FFC",
        ville: "FutureVille",
        couleurPrincipale: "Blanc",
        couleurSecondaire: "Noir",
        dateCreation: DateTime.now().add(Duration(days: 365)),
        budget: 1000000,
        massesSalariales: 500000,
        logo: "futur_logo.png",
        hymne: "Vers le futur!",
        president: "John Future",
        directeurSportif: "Jane Future",
        centreEntrainement: "Future Center",
        supporteurs: 0,
        palmares: [],
        joueurs: [],
        staffs: [],
        stade: stade,
        sponsors: [],
      );

      await box.put('equipe3', equipe);

      final fromHive = box.get('equipe3');

      expect(fromHive!.dateCreation.isAfter(DateTime.now()), isTrue);

      await box.close();
    });
  });
}
