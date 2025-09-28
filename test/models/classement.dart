import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/classement.dart';
import 'package:team_manager_app/models/position_classement.dart';

void main() {
  setUpAll(() {
    Hive.init('./hive_testing_path');
    Hive.registerAdapter(ClassementAdapter());
    Hive.registerAdapter(PositionClassementAdapter());
  });

  group('Tests Classement Hive', () {
    test('Création et sauvegarde d\'un Classement', () async {
      final box = await Hive.openBox<Classement>('classementBoxTest');

      final classement = Classement(
        id: 1,
        saison: '2024/2025',
        positions: [
          PositionClassement(
            position: 1,
            points: 75,
            matchsJoues: 30,
            victoires: 23,
            nuls: 6,
            defaites: 1,
            butsMarques: 65,
            butsEncaisses: 20,
            difference: 45,
          ),
          PositionClassement(
            position: 2,
            points: 70,
            matchsJoues: 30,
            victoires: 21,
            nuls: 7,
            defaites: 2,
            butsMarques: 60,
            butsEncaisses: 25,
            difference: 35,
          ),
        ],
        derniereMiseAJour: DateTime.now(),
      );

      await box.put('classement1', classement);
      final fromHive = box.get('classement1');

      expect(fromHive, isNotNull);
      expect(fromHive!.saison, equals('2024/2025'));
      expect(fromHive.positions.length, equals(2));
      expect(fromHive.positions.first.position, equals(1));
      expect(fromHive.positions.last.points, equals(70));

      await box.close();
    });

    test('Modification d\'un Classement', () async {
      final box = await Hive.openBox<Classement>('classementBoxTest');
      final classement = box.get('classement1');

      classement!.saison = '2025/2026';
      classement.positions.add(PositionClassement(
        position: 3,
        points: 65,
        matchsJoues: 30,
        victoires: 20,
        nuls: 5,
        defaites: 5,
        butsMarques: 55,
        butsEncaisses: 30,
        difference: 25,
      ));

      await classement.save();

      final updated = box.get('classement1');

      expect(updated!.saison, equals('2025/2026'));
      expect(updated.positions.length, equals(3));
      expect(updated.positions.last.position, equals(3));

      await box.close();
    });

    test('Suppression d\'un Classement', () async {
      final box = await Hive.openBox<Classement>('classementBoxTest');

      await box.delete('classement1');

      final deleted = box.get('classement1');
      expect(deleted, isNull);

      await box.close();
    });

    test('Cas limites - Liste vide et champs nulls', () async {
      final box = await Hive.openBox<Classement>('classementBoxTest');

      final classement = Classement(
        id: 2,
        saison: '',
        positions: [],
        derniereMiseAJour: DateTime.now(),
      );

      await box.put('classement2', classement);

      final fromHive = box.get('classement2');

      expect(fromHive, isNotNull);
      expect(fromHive!.positions, isEmpty);
      expect(fromHive.saison, equals(''));

      await box.close();
    });
  });
}
