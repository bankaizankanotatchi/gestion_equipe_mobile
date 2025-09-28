import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:team_manager_app/models/joueur.dart';
import 'package:team_manager_app/models/enums/poste_joueur.dart';
import 'package:team_manager_app/models/enums/statut_joueur.dart';
import 'package:team_manager_app/models/enums/pied_fort.dart';

void main() {
  setUpAll(() {
    Hive.init('./hive_testing_path');

    // 🔹 Enregistrement des adapters nécessaires
    Hive.registerAdapter(JoueurAdapter());
    Hive.registerAdapter(PosteJoueurAdapter());
    Hive.registerAdapter(StatutJoueurAdapter());
    Hive.registerAdapter(PiedFortAdapter());
  });

  // ✅ Cas 1 : Création et lecture
  test('Joueur - sauvegarde et lecture Hive', () async {
    final box = await Hive.openBox<Joueur>('joueurBoxTest1');

    final joueur = Joueur(
      id: 1,
      nom: 'Doe',
      prenom: 'John',
      dateNaissance: DateTime(1995, 5, 10),
      telephone: '0600000000',
      email: 'john.doe@test.com',
      adresse: '123 rue test',
      nationalite: 'FR',
      numeroPasseport: 'X123456',
      numeroIdentite: '123456789',
      numeroMaillot: 10,
      poste: PosteJoueur.milieuOffensif,
      postesSecondaires: [PosteJoueur.attaquantCentre, PosteJoueur.ailierGauche],
      piedFort: PiedFort.droit,
      taille: 1.80,
      poids: 75,
      salaire: 120000.0,
      dateContrat: DateTime(2020, 7, 1),
      finContrat: DateTime(2025, 6, 30),
      statut: StatutJoueur.actif,
      blessure: false,
      suspension: false,
      valeurMarchande: 3500000.0,
      formationInitiale: 'Centre de formation Paris',
      languesParlees: ['Français', 'Anglais'],
    );

    await box.put('joueur1', joueur);

    final fromHive = box.get('joueur1');

    expect(fromHive, isNotNull);
    expect(fromHive!.nom, equals('Doe'));
    expect(fromHive.prenom, equals('John'));
    expect(fromHive.numeroMaillot, equals(10));
    expect(fromHive.poste, equals(PosteJoueur.milieuOffensif));
    expect(fromHive.piedFort, equals(PiedFort.droit));
    expect(fromHive.statut, equals(StatutJoueur.actif));
    expect(fromHive.languesParlees, contains('Français'));

    await box.close();
  });

  // ✅ Cas 2 : Mise à jour
  test('Joueur - mise à jour des informations', () async {
    final box = await Hive.openBox<Joueur>('joueurBoxTest2');

    final joueur = Joueur(
      id: 2,
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

    await box.put('joueur2', joueur);

    // 🔹 Mise à jour : statut + blessure
    final updatedJoueur = Joueur(
      id: 2,
      nom: 'Smith',
      prenom: 'Will',
      dateNaissance: joueur.dateNaissance,
      telephone: joueur.telephone,
      email: joueur.email,
      adresse: joueur.adresse,
      nationalite: joueur.nationalite,
      numeroPasseport: joueur.numeroPasseport,
      numeroIdentite: joueur.numeroIdentite,
      numeroMaillot: joueur.numeroMaillot,
      poste: joueur.poste,
      postesSecondaires: joueur.postesSecondaires,
      piedFort: joueur.piedFort,
      taille: joueur.taille,
      poids: joueur.poids,
      salaire: joueur.salaire,
      dateContrat: joueur.dateContrat,
      finContrat: joueur.finContrat,
      statut: StatutJoueur.blesse, // 🔹 mis à jour
      blessure: true,
      suspension: false,
      valeurMarchande: joueur.valeurMarchande,
      formationInitiale: joueur.formationInitiale,
      languesParlees: joueur.languesParlees,
    );

    await box.put('joueur2', updatedJoueur);

    final fromHive = box.get('joueur2');

    expect(fromHive, isNotNull);
    expect(fromHive!.statut, equals(StatutJoueur.blesse));
    expect(fromHive.blessure, isTrue);

    await box.close();
  });

  // ✅ Cas 3 : Suppression
  test('Joueur - suppression', () async {
    final box = await Hive.openBox<Joueur>('joueurBoxTest3');

    final joueur = Joueur(
      id: 3,
      nom: 'Brown',
      prenom: 'Charlie',
      dateNaissance: DateTime(2000, 3, 20),
      telephone: '0800000000',
      email: 'charlie.brown@test.com',
      adresse: '789 rue test',
      nationalite: 'GB',
      numeroPasseport: 'Z111111',
      numeroIdentite: '333333333',
      numeroMaillot: 9,
      poste: PosteJoueur.ailierDroit,
      postesSecondaires: [],
      piedFort: PiedFort.droit,
      taille: 1.75,
      poids: 70,
      salaire: 90000.0,
      dateContrat: DateTime(2022, 1, 1),
      finContrat: DateTime(2026, 12, 31),
      statut: StatutJoueur.actif,
      blessure: false,
      suspension: false,
      valeurMarchande: 1500000.0,
      formationInitiale: 'Academy London',
      languesParlees: ['Anglais'],
    );

    await box.put('joueur3', joueur);

    await box.delete('joueur3');

    final fromHive = box.get('joueur3');

    expect(fromHive, isNull); // doit être supprimé

    await box.close();
  });
}
