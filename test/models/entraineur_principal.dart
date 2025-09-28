import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/entraineur_principal.dart';
import 'package:team_manager_app/models/palmares.dart';
import 'package:team_manager_app/models/enums/niveau_licence.dart';
import 'package:team_manager_app/models/enums/systeme_jeu.dart';

void main() {
  setUpAll(() async {
    Hive.init('./hive_testing_path');

    Hive.registerAdapter(EntraineurPrincipalAdapter());
    Hive.registerAdapter(PalmaresAdapter());
    Hive.registerAdapter(NiveauLicenceAdapter());
    Hive.registerAdapter(SystemeJeuAdapter());
  });

  group('EntraineurPrincipal CRUD Tests', () {
    test('CREATE & READ EntraineurPrincipal', () async {
      final box = await Hive.openBox<EntraineurPrincipal>('entraineurPrincipalBoxTest');

      final palmares = Palmares(
        id: 1,
        titre: "Champion Ligue 1",
        dateObtention: DateTime.now(),
        competition: "Ligue 1", 
        saison: '2024', 
        position: 1, 
        importance: 5,
      );

      final entraineur = EntraineurPrincipal(
        id: 1,
        nom: "Lemoine",
        prenom: "Paul",
        dateNaissance: DateTime(1975, 4, 15),
        telephone: "0123456789",
        email: "paul.lemoine@example.com",
        adresse: "456 Rue Exemple",
        nationalite: "Française",
        numeroPasseport: "FR87654321",
        numeroIdentite: "ID123456",
        licenceEntraineur: "Licence UEFA A",
        niveauLicence: NiveauLicence.avance,
        experience: 15,
        salaire: 90000,
        tactiqueFavorite: "4-3-3",
        systemeJeu: SystemeJeu.systeme343,
        philosophieJeu: "Possession et pressing",
        palmaresEntraineur: [palmares],
      );

      await box.put('entraineur1', entraineur);

      final fromHive = box.get('entraineur1');

      expect(fromHive, isNotNull);
      expect(fromHive!.nom, "Lemoine");
      expect(fromHive.palmaresEntraineur.length, 1);
      expect(fromHive.niveauLicence, NiveauLicence.avance);

      await box.close();
    });

    test('UPDATE EntraineurPrincipal', () async {
      final box = await Hive.openBox<EntraineurPrincipal>('entraineurPrincipalBoxTest');

      final entraineur = box.get('entraineur1')!;
      entraineur.tactiqueFavorite = "3-5-2";
      entraineur.experience = 20;

      await entraineur.save();

      final updated = box.get('entraineur1');

      expect(updated!.tactiqueFavorite, "3-5-2");
      expect(updated.experience, 20);

      await box.close();
    });

    test('DELETE EntraineurPrincipal', () async {
      final box = await Hive.openBox<EntraineurPrincipal>('entraineurPrincipalBoxTest');

      await box.delete('entraineur1');

      final deleted = box.get('entraineur1');
      expect(deleted, isNull);

      await box.close();
    });
  });

  group('EntraineurPrincipal Edge Case Tests', () {
    test('EntraineurPrincipal avec liste palmarès vide', () async {
      final box = await Hive.openBox<EntraineurPrincipal>('entraineurPrincipalBoxTest');

      final entraineur = EntraineurPrincipal(
        id: 2,
        nom: "Test",
        prenom: "Vide",
        dateNaissance: DateTime(1985, 2, 10),
        telephone: "",
        email: "",
        adresse: "",
        nationalite: "",
        numeroPasseport: "",
        numeroIdentite: "",
        licenceEntraineur: "",
        niveauLicence: NiveauLicence.avance,
        experience: 0,
        salaire: 0,
        tactiqueFavorite: "",
        systemeJeu: SystemeJeu.systeme343,
        philosophieJeu: "",
        palmaresEntraineur: [],
      );

      await box.put('entraineur2', entraineur);

      final fromHive = box.get('entraineur2');

      expect(fromHive!.palmaresEntraineur.isEmpty, isTrue);
      expect(fromHive.nom.isEmpty, isFalse);

      await box.close();
    });

    test('EntraineurPrincipal avec dateNaissance future', () async {
      final box = await Hive.openBox<EntraineurPrincipal>('entraineurPrincipalBoxTest');

      final entraineur = EntraineurPrincipal(
        id: 3,
        nom: "Futur",
        prenom: "Coach",
        dateNaissance: DateTime.now().add(const Duration(days: 365)),
        telephone: "0000000000",
        email: "futur.coach@example.com",
        adresse: "123 Futur Street",
        nationalite: "Inconnue",
        numeroPasseport: "XX000000",
        numeroIdentite: "ID000000",
        licenceEntraineur: "Licence Inconnue",
        niveauLicence: NiveauLicence.avance,
        experience: 1,
        salaire: 50000,
        tactiqueFavorite: "4-4-2",
        systemeJeu: SystemeJeu.systeme343,
        philosophieJeu: "Attaque rapide",
        palmaresEntraineur: [],
      );

      await box.put('entraineur3', entraineur);

      final fromHive = box.get('entraineur3');

      expect(fromHive!.dateNaissance.isAfter(DateTime.now()), isTrue);

      await box.close();
    });
  });
}
