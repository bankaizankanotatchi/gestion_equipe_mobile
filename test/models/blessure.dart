import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:team_manager_app/models/blessure.dart';
import 'package:team_manager_app/models/suivi_blessure.dart';
import 'package:team_manager_app/models/enums/type_blessure.dart';
import 'package:team_manager_app/models/enums/gravite_blessure.dart';
import 'package:team_manager_app/models/enums/impact_carriere.dart';

void main() {
  setUpAll(() {
    Hive.init('./hive_testing_path');

    // 🔹 Enregistrement des adapters Hive pour tous les modèles et enums utilisés
    Hive.registerAdapter(BlessureAdapter());
    Hive.registerAdapter(SuiviBlessureAdapter());
    Hive.registerAdapter(TypeBlessureAdapter());
    Hive.registerAdapter(GraviteBlessureAdapter());
    Hive.registerAdapter(ImpactCarriereAdapter());
  });

  test('Blessure - sauvegarde et lecture Hive', () async {
    final box = await Hive.openBox<Blessure>('blessureBoxTest');

    final blessure = Blessure(
      id: 1,
      type: TypeBlessure.musculaire,
      gravite: GraviteBlessure.moyenne,
      dateBlessure: DateTime(2023, 8, 12),
      dureeEstimee: 30,
      dureeReelle: 28,
      description: 'Entorse du genou gauche lors d’un match',
      soigne: true,
      dateRetour: DateTime(2023, 9, 10),
      circumstancesBlessure: 'Match amical',
      traitement: 'Repos, physiothérapie',
      suivi: [
        SuiviBlessure(
          id: 1,
          dateVisite: DateTime(2023, 8, 13),
          evolution: 'Première consultation',
          douleur: 3,
          mobilite: 7,
          recommandations: 'Repos complet',
          prochainRendezVous: DateTime(2023, 8, 20),
        ),
        SuiviBlessure(
          id: 2,
          dateVisite: DateTime(2023, 8, 20),
          evolution: 'Progrès notables',
          douleur: 2,
          mobilite: 8,
          recommandations: 'Physiothérapie',
          prochainRendezVous: DateTime(2023, 9, 5),
        ),
      ],
      recidive: false,
      impactCarriere: ImpactCarriere.temporaire,
    );

    await box.put('blessure1', blessure);

    final fromHive = box.get('blessure1');

    expect(fromHive, isNotNull);
    expect(fromHive!.description, equals('Entorse du genou gauche lors d’un match'));
    expect(fromHive.type, equals(TypeBlessure.musculaire));
    expect(fromHive.gravite, equals(GraviteBlessure.moyenne));
    expect(fromHive.suivi.length, equals(2));

    await box.close();
  });

  test('Blessure - mise à jour', () async {
    final box = await Hive.openBox<Blessure>('blessureBoxTest');

    var blessure = box.get('blessure1');
    expect(blessure, isNotNull);

    blessure!.dureeReelle = 35;
    blessure.suivi.add(
      SuiviBlessure(
        id: 3,
        dateVisite: DateTime(2023, 9, 5),
        evolution: 'Reprise progressive',
        douleur: 1,
        mobilite: 9,
        recommandations: 'Entraînement léger',
        prochainRendezVous: DateTime(2023, 9, 15),
      ),
    );
    await blessure.save();

    final updated = box.get('blessure1');
    expect(updated!.dureeReelle, equals(35));
    expect(updated.suivi.length, equals(3));
    expect(updated.suivi.last.evolution, equals('Reprise progressive')); 

    await box.close();
  });

  test('Blessure - suppression', () async {
    final box = await Hive.openBox<Blessure>('blessureBoxTest');

    await box.delete('blessure1');
    final deleted = box.get('blessure1');

    expect(deleted, isNull);

    await box.close();
  });
}
