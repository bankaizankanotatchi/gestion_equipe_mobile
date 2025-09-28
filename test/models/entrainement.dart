import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/entrainement.dart';
import 'package:team_manager_app/models/exercice.dart';
import 'package:team_manager_app/models/enums/type_entrainement.dart';
import 'package:team_manager_app/models/enums/niveau_intensite.dart';
import 'package:team_manager_app/models/enums/conditions_meteo.dart';

void main() {
  setUpAll(() async {
    Hive.init('./hive_testing_path');

    Hive.registerAdapter(EntrainementAdapter());
    Hive.registerAdapter(ExerciceAdapter());
    Hive.registerAdapter(TypeEntrainementAdapter());
    Hive.registerAdapter(NiveauIntensiteAdapter());
    Hive.registerAdapter(ConditionsMeteoAdapter());
  });

  group('Entrainement CRUD Tests', () {
    test('CREATE & READ Entrainement', () async {
      final box = await Hive.openBox<Entrainement>('entrainementBoxTest');

      final exercice = Exercice(
        id: 1,
        nom: "Dribbles",
        description: "Exercice de dribble en zigzag",
        duree: 20,
        materiel: ["Plots", "Ballons"],
        competencesTrainees: ["Dribble", "Coordination"],
        difficulte: 3,
      );

      final entrainement = Entrainement(
        id: 1,
        dateEntrainement: DateTime.now(),
        duree: 90,
        type: TypeEntrainement.technique,
        intensite: NiveauIntensite.eleve,
        objectifs: ["Améliorer dribble", "Augmenter endurance"],
        exercices: [exercice],
        participantsPresents: [],
        participantsAbsents: [],
        conditions: ConditionsMeteo.ensoleille,
      );

      await box.put('entrainement1', entrainement);

      final fromHive = box.get('entrainement1');

      expect(fromHive, isNotNull);
      expect(fromHive!.duree, 90);
      expect(fromHive.exercices.length, 1);
      expect(fromHive.exercices.first.nom, "Dribbles");

      await box.close();
    });

    test('UPDATE Entrainement', () async {
      final box = await Hive.openBox<Entrainement>('entrainementBoxTest');

      final entrainement = box.get('entrainement1')!;
      entrainement.duree = 100;
      entrainement.intensite = NiveauIntensite.moyen;

      await entrainement.save();

      final updated = box.get('entrainement1');

      expect(updated!.duree, 100);
      expect(updated.intensite, NiveauIntensite.moyen);

      await box.close();
    });

    test('DELETE Entrainement', () async {
      final box = await Hive.openBox<Entrainement>('entrainementBoxTest');

      await box.delete('entrainement1');

      final deleted = box.get('entrainement1');
      expect(deleted, isNull);

      await box.close();
    });
  });

  group('Entrainement Edge Case Tests', () {
    test('Entrainement avec liste d’exercices vide', () async {
      final box = await Hive.openBox<Entrainement>('entrainementBoxTest');

      final entrainement = Entrainement(
        id: 2,
        dateEntrainement: DateTime.now(),
        duree: 60,
        type: TypeEntrainement.physique,
        intensite: NiveauIntensite.faible,
        objectifs: [],
        exercices: [],
        participantsPresents: [],
        participantsAbsents: [],
        conditions: ConditionsMeteo.pluie,
      );

      await box.put('entrainement2', entrainement);

      final fromHive = box.get('entrainement2');

      expect(fromHive!.exercices.isEmpty, isTrue);
      expect(fromHive.objectifs.isEmpty, isTrue);

      await box.close();
    });

    test('Entrainement avec date passée', () async {
      final box = await Hive.openBox<Entrainement>('entrainementBoxTest');

      final entrainement = Entrainement(
        id: 3,
        dateEntrainement: DateTime.now().subtract(Duration(days: 5)),
        duree: 45,
        type: TypeEntrainement.mental,
        intensite: NiveauIntensite.faible,
        objectifs: ["Gestion du stress"],
        exercices: [],
        participantsPresents: [],
        participantsAbsents: [],
        conditions: ConditionsMeteo.vent,
      );

      await box.put('entrainement3', entrainement);

      final fromHive = box.get('entrainement3');

      expect(fromHive!.dateEntrainement.isBefore(DateTime.now()), isTrue);

      await box.close();
    });
  });
}
