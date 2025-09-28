import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/composition.dart';
import 'package:team_manager_app/models/enums/systeme_jeu.dart';
import 'package:team_manager_app/models/joueur.dart';
import 'package:team_manager_app/models/enums/poste_joueur.dart';
import 'package:team_manager_app/models/enums/statut_joueur.dart';
import 'package:team_manager_app/models/enums/pied_fort.dart';

void main() {
  setUpAll(() {
    Hive.init('./hive_testing_path');

    Hive.registerAdapter(CompositionAdapter());
    Hive.registerAdapter(SystemeJeuAdapter());
    Hive.registerAdapter(JoueurAdapter());
    Hive.registerAdapter(PosteJoueurAdapter());
    Hive.registerAdapter(StatutJoueurAdapter());
    Hive.registerAdapter(PiedFortAdapter());
  });

  group('Composition CRUD Tests', () {
    test('CREATE & READ Composition', () async {
      final box = await Hive.openBox<Composition>('compositionBoxTest');

      final joueur = Joueur(
        id: 1,
        nom: 'Doe',
        prenom: 'John',
        dateNaissance: DateTime(1990, 1, 1),
        telephone: '123456789',
        email: 'john@example.com',
        adresse: '123 rue Exemple',
        nationalite: 'Française',
        numeroPasseport: 'P123456',
        numeroIdentite: 'ID987654',
        numeroMaillot: 10,
        poste: PosteJoueur.ailierDroit,
        postesSecondaires: [PosteJoueur.milieuDefensif],
        piedFort: PiedFort.droit,
        taille: 1.80,
        poids: 75,
        salaire: 100000,
        dateContrat: DateTime.now(),
        finContrat: DateTime.now().add(const Duration(days: 365)),
        statut: StatutJoueur.actif,
        blessure: false,
        suspension: false,
        valeurMarchande: 500000,
        formationInitiale: "Académie locale",
        languesParlees: ['Français', 'Anglais'],
      );

      final composition = Composition(
        id: 1,
        systemeJeu: SystemeJeu.systeme433,
        dateComposition: DateTime.now(),
        titulaires: [joueur],
        remplacants: [],
        capitaine: joueur,
        tireursPenalty: [joueur],
        tireursCoups: [],
        validee: true,
      );

      await box.put('composition1', composition);

      final fromHive = box.get('composition1');

      expect(fromHive, isNotNull);
      expect(fromHive!.systemeJeu, SystemeJeu.systeme433);
      expect(fromHive.titulaires.length, 1);
      expect(fromHive.capitaine.nom, 'Doe');

      await box.close();
    });

    test('UPDATE Composition', () async {
      final box = await Hive.openBox<Composition>('compositionBoxTest');

      final composition = box.get('composition1')!;
      composition.validee = false;
      composition.systemeJeu = SystemeJeu.systeme442;

      await composition.save();

      final updated = box.get('composition1');

      expect(updated!.validee, isFalse);
      expect(updated.systemeJeu, SystemeJeu.systeme442);

      await box.close();
    });

    test('DELETE Composition', () async {
      final box = await Hive.openBox<Composition>('compositionBoxTest');

      await box.delete('composition1');

      final deleted = box.get('composition1');
      expect(deleted, isNull);

      await box.close();
    });
  });

  group('Composition Edge Case Tests', () {
    test('Composition avec liste joueurs vide', () async {
      final box = await Hive.openBox<Composition>('compositionBoxTest');

      final joueur = Joueur(
        id: 2,
        nom: 'Smith',
        prenom: 'Anna',
        dateNaissance: DateTime(1992, 3, 3),
        telephone: '987654321',
        email: 'anna@example.com',
        adresse: '456 rue Exemple',
        nationalite: 'Française',
        numeroPasseport: 'P654321',
        numeroIdentite: 'ID123456',
        numeroMaillot: 9,
        poste: PosteJoueur.milieuDefensif,
        postesSecondaires: [],
        piedFort: PiedFort.gauche,
        taille: 1.70,
        poids: 65,
        salaire: 80000,
        dateContrat: DateTime.now(),
        finContrat: DateTime.now().add(const Duration(days: 180)),
        statut: StatutJoueur.actif,
        blessure: false,
        suspension: false,
        valeurMarchande: 300000,
        formationInitiale: "Académie régionale",
        languesParlees: ['Français'],
      );

      final composition = Composition(
        id: 2,
        systemeJeu: SystemeJeu.systeme352,
        dateComposition: DateTime.now(),
        titulaires: [],
        remplacants: [],
        capitaine: joueur,
        tireursPenalty: [],
        tireursCoups: [],
        validee: false,
      );

      await box.put('composition2', composition);

      final fromHive = box.get('composition2');

      expect(fromHive!.titulaires.isEmpty, isTrue);
      expect(fromHive.remplacants.isEmpty, isTrue);

      await box.close();
    });

    test('Date composition passée', () async {
      final box = await Hive.openBox<Composition>('compositionBoxTest');

      final joueur = Joueur(
        id: 3,
        nom: 'Durand',
        prenom: 'Paul',
        dateNaissance: DateTime(1988, 5, 5),
        telephone: '112233445',
        email: 'paul@example.com',
        adresse: '789 rue Exemple',
        nationalite: 'Française',
        numeroPasseport: 'P987654',
        numeroIdentite: 'ID654321',
        numeroMaillot: 8,
        poste: PosteJoueur.defenseurCentral,
        postesSecondaires: [],
        piedFort: PiedFort.droit,
        taille: 1.85,
        poids: 80,
        salaire: 90000,
        dateContrat: DateTime.now(),
        finContrat: DateTime.now().add(Duration(days: 300)),
        statut: StatutJoueur.actif,
        blessure: false,
        suspension: false,
        valeurMarchande: 400000,
        formationInitiale: "Académie nationale",
        languesParlees: ['Français', 'Espagnol'],
      );

      final composition = Composition(
        id: 3,
        systemeJeu: SystemeJeu.systeme541,
        dateComposition: DateTime.now().subtract(Duration(days: 1)),
        titulaires: [joueur],
        remplacants: [],
        capitaine: joueur,
        tireursPenalty: [],
        tireursCoups: [],
        validee: true,
      );

      await box.put('composition3', composition);

      final fromHive = box.get('composition3');

      expect(fromHive!.dateComposition.isBefore(DateTime.now()), isTrue);

      await box.close();
    });
  });
}
