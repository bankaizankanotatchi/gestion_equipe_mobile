import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/competition.dart';
import 'package:team_manager_app/models/classement.dart';
import 'package:team_manager_app/models/palmares.dart';
import 'package:team_manager_app/models/enums/type_competition.dart';
import 'package:team_manager_app/models/enums/niveau_competition.dart';
import 'package:team_manager_app/models/enums/format_competition.dart';

void main() {
  setUpAll(() {
    Hive.init('./hive_testing_path');

    Hive.registerAdapter(CompetitionAdapter());
    Hive.registerAdapter(ClassementAdapter());
    Hive.registerAdapter(PalmaresAdapter());
    Hive.registerAdapter(TypeCompetitionAdapter());
    Hive.registerAdapter(NiveauCompetitionAdapter());
    Hive.registerAdapter(FormatCompetitionAdapter());
  });

  group('Competition CRUD Tests', () {
    test('CREATE & READ Competition', () async {
      final box = await Hive.openBox<Competition>('competitionBoxTest');

      final palmares = [
        Palmares(
          id: 1,
          competition: 'Coupe Nationale',
          saison: '2024',
          position: 1,
          dateObtention: DateTime.now(),
          titre: 'Champion',
          importance: 5,
        ),
      ];

      final classement = Classement(
        id: 1,
        saison: '2024',
        positions: [],
        derniereMiseAJour: DateTime.now(),
      );

      final competition = Competition(
        id: 1,
        nom: 'Coupe Nationale',
        type: TypeCompetition.coupeNationale,
        niveau: NiveauCompetition.national,
        saison: '2024',
        dateDebut: DateTime.now(),
        dateFin: DateTime.now().add(const Duration(days: 30)),
        nombreEquipes: 16,
        format: FormatCompetition.coupe,
        dotation: 50000.0,
        sponsor: 'Sponsor X',
        organisateur: 'Fédération Nationale',
        reglements: 'Règlement spécial',
        palmares: palmares,
        classement: classement,
      );

      await box.put('competition1', competition);

      final fromHive = box.get('competition1');

      expect(fromHive, isNotNull);
      expect(fromHive!.nom, equals('Coupe Nationale'));
      expect(fromHive.palmares.length, equals(1));
      expect(fromHive.classement.saison, equals('2024'));

      await box.close();
    });

    test('UPDATE Competition', () async {
      final box = await Hive.openBox<Competition>('competitionBoxTest');

      final comp = box.get('competition1')!;
      comp.dotation = 100000.0;
      comp.sponsor = 'Sponsor Y';

      await comp.save();

      final updated = box.get('competition1');

      expect(updated!.dotation, equals(100000.0));
      expect(updated.sponsor, equals('Sponsor Y'));

      await box.close();
    });

    test('DELETE Competition', () async {
      final box = await Hive.openBox<Competition>('competitionBoxTest');

      await box.delete('competition1');

      final deleted = box.get('competition1');
      expect(deleted, isNull);

      await box.close();
    });
  });

  group('Competition Edge Case Tests', () {
    test('NombreEquipes = 0', () async {
      final box = await Hive.openBox<Competition>('competitionBoxTest');

      final comp = Competition(
        id: 2,
        nom: 'Test Competition',
        type: TypeCompetition.matchAmical,
        niveau: NiveauCompetition.local,
        saison: '2025',
        dateDebut: DateTime.now(),
        dateFin: DateTime.now().add(const Duration(days: 10)),
        nombreEquipes: 0,
        format: FormatCompetition.groupes,
        dotation: 0.0,
        sponsor: '',
        organisateur: '',
        reglements: '',
        palmares: [],
        classement: Classement(id: 2, saison: '2025', positions: [], derniereMiseAJour: DateTime.now()),
      );

      await box.put('competition2', comp);
      final fromHive = box.get('competition2');

      expect(fromHive!.nombreEquipes, equals(0));

      await box.close();
    });

    test('DateFin avant DateDebut', () async {
      final box = await Hive.openBox<Competition>('competitionBoxTest');

      final comp = Competition(
        id: 3,
        nom: 'Competition Erreur Date',
        type: TypeCompetition.tournoi,
        niveau: NiveauCompetition.continental,
        saison: '2025',
        dateDebut: DateTime.now(),
        dateFin: DateTime.now().subtract(const Duration(days: 1)),
        nombreEquipes: 8,
        format: FormatCompetition.eliminationDirecte,
        dotation: 1000.0,
        sponsor: 'Sponsor Test',
        organisateur: 'Organisateur Test',
        reglements: 'Test règles',
        palmares: [],
        classement: Classement(id: 3, saison: '2025', positions: [], derniereMiseAJour: DateTime.now()),
      );

      await box.put('competition3', comp);

      final fromHive = box.get('competition3');
      expect(fromHive!.dateFin.isBefore(fromHive.dateDebut), isTrue);

      await box.close();
    });

    test('Palmares vide', () async {
      final box = await Hive.openBox<Competition>('competitionBoxTest');

      final comp = Competition(
        id: 4,
        nom: 'Competition Sans Palmares',
        type: TypeCompetition.championnat,
        niveau: NiveauCompetition.mondial,
        saison: '2025',
        dateDebut: DateTime.now(),
        dateFin: DateTime.now().add(const Duration(days: 20)),
        nombreEquipes: 20,
        format: FormatCompetition.championnat,
        dotation: 20000.0,
        sponsor: 'Sponsor Test',
        organisateur: 'Organisateur Test',
        reglements: 'Règles Test',
        palmares: [],
        classement: Classement(id: 4, saison: '2025', positions: [], derniereMiseAJour: DateTime.now()),
      );

      await box.put('competition4', comp);

      final fromHive = box.get('competition4');
      expect(fromHive!.palmares.isEmpty, isTrue);

      await box.close();
    });
  });
}
