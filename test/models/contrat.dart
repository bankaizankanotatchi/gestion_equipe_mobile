import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/contrat.dart';
import 'package:team_manager_app/models/prime.dart';
import 'package:team_manager_app/models/clause.dart';
import 'package:team_manager_app/models/enums/type_prime.dart';
import 'package:team_manager_app/models/enums/type_clause.dart';

void main() {
  setUpAll(() async {
    Hive.init('./hive_testing_path');

    Hive.registerAdapter(ContratAdapter());
    Hive.registerAdapter(PrimeAdapter());
    Hive.registerAdapter(ClauseAdapter());
    Hive.registerAdapter(TypePrimeAdapter());
    Hive.registerAdapter(TypeClauseAdapter());
  });

  group('Contrat CRUD Tests', () {
    test('CREATE & READ Contrat', () async {
      final box = await Hive.openBox<Contrat>('contratBoxTest');

      final prime = Prime(
        id: 1,
        type: TypePrime.match,
        montant: 1000,
        condition: "Victoire obligatoire",
        atteinte: false,
      );

      final clause = Clause(
        id: 1,
        type: TypeClause.performance,
        description: "Clause de performance",
        montant: 5000,
        conditions: "Atteindre objectifs",
        active: true,
        dateExpiration: DateTime.now().add(Duration(days: 180)),
      );

      final contrat = Contrat(
        id: 1,
        dateDebut: DateTime.now(),
        dateFin: DateTime.now().add(Duration(days: 365)),
        salaireBrut: 120000,
        primes: [prime],
        clauses: [clause],
        assurances: ["Assurance santé", "Assurance vie"],
        avantages: ["Voiture", "Logement"],
        prolongeable: true,
        resiliable: false,
      );

      await box.put('contrat1', contrat);

      final fromHive = box.get('contrat1');

      expect(fromHive, isNotNull);
      expect(fromHive!.salaireBrut, 120000);
      expect(fromHive.primes.length, 1);
      expect(fromHive.clauses.first.type, TypeClause.performance);

      await box.close();
    });

    test('UPDATE Contrat', () async {
      final box = await Hive.openBox<Contrat>('contratBoxTest');

      final contrat = box.get('contrat1')!;
      contrat.salaireBrut = 130000;
      contrat.prolongeable = false;

      await contrat.save();

      final updated = box.get('contrat1');

      expect(updated!.salaireBrut, 130000);
      expect(updated.prolongeable, isFalse);

      await box.close();
    });

    test('DELETE Contrat', () async {
      final box = await Hive.openBox<Contrat>('contratBoxTest');

      await box.delete('contrat1');

      final deleted = box.get('contrat1');
      expect(deleted, isNull);

      await box.close();
    });
  });

  group('Contrat Edge Case Tests', () {
    test('Contrat avec primes et clauses vides', () async {
      final box = await Hive.openBox<Contrat>('contratBoxTest');

      final contrat = Contrat(
        id: 2,
        dateDebut: DateTime.now(),
        dateFin: DateTime.now().add(Duration(days: 365)),
        salaireBrut: 90000,
        primes: [],
        clauses: [],
        assurances: [],
        avantages: [],
        prolongeable: false,
        resiliable: true,
      );

      await box.put('contrat2', contrat);

      final fromHive = box.get('contrat2');

      expect(fromHive!.primes.isEmpty, isTrue);
      expect(fromHive.clauses.isEmpty, isTrue);

      await box.close();
    });

    test('Contrat avec dateFin passée', () async {
      final box = await Hive.openBox<Contrat>('contratBoxTest');

      final contrat = Contrat(
        id: 3,
        dateDebut: DateTime.now().subtract(Duration(days: 400)),
        dateFin: DateTime.now().subtract(Duration(days: 30)),
        salaireBrut: 80000,
        primes: [],
        clauses: [],
        assurances: ["Assurance santé"],
        avantages: ["Prime exceptionnelle"],
        prolongeable: false,
        resiliable: true,
      );

      await box.put('contrat3', contrat);

      final fromHive = box.get('contrat3');

      expect(fromHive!.dateFin.isBefore(DateTime.now()), isTrue);

      await box.close();
    });
  });
}
