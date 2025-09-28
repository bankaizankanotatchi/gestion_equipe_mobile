import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:team_manager_app/models/joueur.dart';
import 'package:team_manager_app/models/enums/poste_joueur.dart';
import 'package:team_manager_app/models/enums/statut_joueur.dart';
import 'package:team_manager_app/models/enums/pied_fort.dart';

void main() {
  setUpAll(() {
    Hive.init('./hive_testing_path');

    // 🔹 On enregistre tous les adapters nécessaires
    Hive.registerAdapter(JoueurAdapter());
    Hive.registerAdapter(PosteJoueurAdapter());
    Hive.registerAdapter(StatutJoueurAdapter());
    Hive.registerAdapter(PiedFortAdapter());
  });

  test('Joueur - sauvegarde et lecture Hive', () async {
    final box = await Hive.openBox<Joueur>('joueurBoxTest');

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
}
