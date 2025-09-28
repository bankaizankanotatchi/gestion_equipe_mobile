import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:team_manager_app/models/agent.dart';
import 'package:team_manager_app/models/joueur.dart';
import 'package:team_manager_app/models/enums/poste_joueur.dart';
import 'package:team_manager_app/models/enums/statut_joueur.dart';
import 'package:team_manager_app/models/enums/pied_fort.dart';

void main() {
  setUpAll(() {
    Hive.init('./hive_testing_path');

    // 🔹 Enregistrement des adapters nécessaires
    Hive.registerAdapter(AgentAdapter());
    Hive.registerAdapter(JoueurAdapter());
    Hive.registerAdapter(PosteJoueurAdapter());
    Hive.registerAdapter(StatutJoueurAdapter());
    Hive.registerAdapter(PiedFortAdapter());
  });

  // ✅ Cas 1 : Sauvegarde et lecture d’un agent avec un client
  test('Agent - sauvegarde et lecture Hive avec un client', () async {
    final box = await Hive.openBox<Agent>('agentBoxTest1');

    final joueurClient = Joueur(
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
      postesSecondaires: [PosteJoueur.attaquantCentre],
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

    final agent = Agent(
      id: 101,
      nom: 'Smith',
      prenom: 'Alice',
      agence: 'TopSports',
      licence: 'AG12345',
      commission: 8.5,
      clients: [joueurClient],
      experience: 12,
      reputation: 90,
    );

    await box.put('agent1', agent);

    final fromHive = box.get('agent1');

    expect(fromHive, isNotNull);
    expect(fromHive!.nom, equals('Smith'));
    expect(fromHive.clients.first.nom, equals('Doe')); // Vérifie le joueur lié

    await box.close();
  });

  // ✅ Cas 2 : Sauvegarde et lecture d’un agent sans client
  test('Agent - sauvegarde et lecture Hive sans client', () async {
    final box = await Hive.openBox<Agent>('agentBoxTest2');

    final agent = Agent(
      id: 102,
      nom: 'Johnson',
      prenom: 'Bob',
      agence: 'EliteSport',
      licence: 'AG67890',
      commission: 5.0,
      clients: [], // aucun joueur
      experience: 5,
      reputation: 70,
    );

    await box.put('agent2', agent);

    final fromHive = box.get('agent2');

    expect(fromHive, isNotNull);
    expect(fromHive!.clients, isEmpty); // Vérifie bien que la liste est vide
    expect(fromHive.nom, equals('Johnson'));

    await box.close();
  });

  // ✅ Cas 3 : Vérifier la mise à jour d’un agent déjà existant
  test('Agent - mise à jour des informations', () async {
    final box = await Hive.openBox<Agent>('agentBoxTest3');

    final agent = Agent(
      id: 103,
      nom: 'Taylor',
      prenom: 'Emma',
      agence: 'SuperAgents',
      licence: 'AG33333',
      commission: 7.0,
      clients: [],
      experience: 8,
      reputation: 85,
    );

    await box.put('agent3', agent);

    // 🔹 On met à jour la commission et la réputation
    final updatedAgent = Agent(
      id: 103,
      nom: 'Taylor',
      prenom: 'Emma',
      agence: 'SuperAgents',
      licence: 'AG33333',
      commission: 10.0,
      clients: [],
      experience: 8,
      reputation: 95,
    );

    await box.put('agent3', updatedAgent);

    final fromHive = box.get('agent3');

    expect(fromHive, isNotNull);
    expect(fromHive!.commission, equals(10.0));
    expect(fromHive.reputation, equals(95));

    await box.close();
  });

  // ✅ Cas 4 : Suppression d’un agent
  test('Agent - suppression d’un enregistrement', () async {
    final box = await Hive.openBox<Agent>('agentBoxTest4');

    final agent = Agent(
      id: 104,
      nom: 'Williams',
      prenom: 'George',
      agence: 'BigAgency',
      licence: 'AG99999',
      commission: 6.5,
      clients: [],
      experience: 10,
      reputation: 80,
    );

    await box.put('agent4', agent);

    await box.delete('agent4'); // suppression

    final fromHive = box.get('agent4');

    expect(fromHive, isNull); // Vérifie que l’agent n’existe plus

    await box.close();
  });
}
