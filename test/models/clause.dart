import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/clause.dart';
import 'package:team_manager_app/models/enums/type_clause.dart';

void main() {
  // Initialisation de Hive avant les tests
  setUpAll(() {
    Hive.init('./hive_testing_path');

    Hive.registerAdapter(ClauseAdapter());
    Hive.registerAdapter(TypeClauseAdapter());
  });

  group('Clause CRUD Tests', () {
    // TEST CREATE & READ
    test('CREATE & READ Clause', () async {
      final box = await Hive.openBox<Clause>('clauseBoxTest');

      // Création d'une clause
      final clause = Clause(
        id: 1,
        type: TypeClause.liberatoire,
        description: 'Clause de libération',
        montant: 50000.0,
        conditions: 'Conditions spéciales',
        active: true,
        dateExpiration: DateTime.now().add(const Duration(days: 365)),
      );

      await box.put('clause1', clause); // Sauvegarde

      final fromHive = box.get('clause1'); // Lecture

      // Vérification que la clause a été correctement stockée
      expect(fromHive, isNotNull);
      expect(fromHive!.type, equals(TypeClause.liberatoire));
      expect(fromHive.montant, equals(50000.0));
      expect(fromHive.conditions, contains('Conditions'));
      expect(fromHive.active, isTrue);

      await box.close();
    });

    // TEST UPDATE
    test('UPDATE Clause', () async {
      final box = await Hive.openBox<Clause>('clauseBoxTest');

      final clause = box.get('clause1')!;
      clause.montant = 75000.0; // Modification
      clause.active = false;

      await clause.save(); // Sauvegarde

      final updated = box.get('clause1');

      // Vérification des modifications
      expect(updated!.montant, equals(75000.0));
      expect(updated.active, isFalse);

      await box.close();
    });

    // TEST DELETE
    test('DELETE Clause', () async {
      final box = await Hive.openBox<Clause>('clauseBoxTest');

      await box.delete('clause1');

      final deleted = box.get('clause1');

      // Vérification que la clause a été supprimée
      expect(deleted, isNull);

      await box.close();
    });
  });

  group('Clause Edge Case Tests', () {
    // CAS LIMITE: Montant = 0
    test('Montant = 0', () async {
      final box = await Hive.openBox<Clause>('clauseBoxTest');

      final clause = Clause(
        id: 2,
        type: TypeClause.performance,
        description: 'Clause test montant zéro',
        montant: 0.0,
        conditions: 'Aucune condition',
        active: true,
        dateExpiration: DateTime.now().add(const Duration(days: 10)),
      );

      await box.put('clause2', clause);

      final fromHive = box.get('clause2');

      expect(fromHive!.montant, equals(0.0));

      await box.close();
    });

    // CAS LIMITE: DateExpiration passée
    test('DateExpiration passée', () async {
      final box = await Hive.openBox<Clause>('clauseBoxTest');

      final clause = Clause(
        id: 3,
        type: TypeClause.confidentialite,
        description: 'Clause test date passée',
        montant: 1000.0,
        conditions: 'Test date passée',
        active: true,
        dateExpiration: DateTime.now().subtract(const Duration(days: 1)),
      );

      await box.put('clause3', clause);

      final fromHive = box.get('clause3');

      expect(fromHive!.dateExpiration.isBefore(DateTime.now()), isTrue);

      await box.close();
    });

    // CAS LIMITE: Description vide
    test('Description vide', () async {
      final box = await Hive.openBox<Clause>('clauseBoxTest');

      final clause = Clause(
        id: 4,
        type: TypeClause.autre,
        description: '',
        montant: 1000.0,
        conditions: '',
        active: true,
        dateExpiration: DateTime.now().add(const Duration(days: 30)),
      );

      await box.put('clause4', clause);

      final fromHive = box.get('clause4');

      expect(fromHive!.description, isEmpty);

      await box.close();
    });
  });
}
