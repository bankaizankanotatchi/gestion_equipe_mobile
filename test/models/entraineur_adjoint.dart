import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:team_manager_app/models/entraineur_adjoint.dart';

void main() {
  setUpAll(() async {
    Hive.init('./hive_testing_path');

    Hive.registerAdapter(EntraineurAdjointAdapter());
  });

  group('EntraineurAdjoint CRUD Tests', () {
    test('CREATE & READ EntraineurAdjoint', () async {
      final box = await Hive.openBox<EntraineurAdjoint>('entraineurAdjointBoxTest');

      final entraineur = EntraineurAdjoint(
        id: 1,
        nom: "Dupont",
        prenom: "Jean",
        dateNaissance: DateTime(1980, 5, 10),
        telephone: "0123456789",
        email: "jean.dupont@example.com",
        adresse: "123 Rue Exemple",
        nationalite: "Française",
        numeroPasseport: "FR12345678",
        numeroIdentite: "ID987654",
        specialite: "Préparation physique",
        licenceEntraineur: "Licence UEFA B",
        niveauResponsabilite: 2,
      );

      await box.put('entraineur1', entraineur);

      final fromHive = box.get('entraineur1');

      expect(fromHive, isNotNull);
      expect(fromHive!.nom, "Dupont");
      expect(fromHive.specialite, "Préparation physique");

      await box.close();
    });

    test('UPDATE EntraineurAdjoint', () async {
      final box = await Hive.openBox<EntraineurAdjoint>('entraineurAdjointBoxTest');

      final entraineur = box.get('entraineur1')!;
      entraineur.specialite = "Tactique";
      entraineur.niveauResponsabilite = 3;

      await entraineur.save();

      final updated = box.get('entraineur1');

      expect(updated!.specialite, "Tactique");
      expect(updated.niveauResponsabilite, 3);

      await box.close();
    });

    test('DELETE EntraineurAdjoint', () async {
      final box = await Hive.openBox<EntraineurAdjoint>('entraineurAdjointBoxTest');

      await box.delete('entraineur1');

      final deleted = box.get('entraineur1');
      expect(deleted, isNull);

      await box.close();
    });
  });

  group('EntraineurAdjoint Edge Case Tests', () {
    test('EntraineurAdjoint avec champs vides', () async {
      final box = await Hive.openBox<EntraineurAdjoint>('entraineurAdjointBoxTest');

      final entraineur = EntraineurAdjoint(
        id: 2,
        nom: "",
        prenom: "",
        dateNaissance: DateTime(2000, 1, 1),
        telephone: "",
        email: "",
        adresse: "",
        nationalite: "",
        numeroPasseport: "",
        numeroIdentite: "",
        specialite: "",
        licenceEntraineur: "",
        niveauResponsabilite: 0,
      );

      await box.put('entraineur2', entraineur);

      final fromHive = box.get('entraineur2');

      expect(fromHive!.nom.isEmpty, isTrue);
      expect(fromHive.specialite.isEmpty, isTrue);
      expect(fromHive.niveauResponsabilite, 0);

      await box.close();
    });

    test('EntraineurAdjoint avec dateNaissance future', () async {
      final box = await Hive.openBox<EntraineurAdjoint>('entraineurAdjointBoxTest');

      final entraineur = EntraineurAdjoint(
        id: 3,
        nom: "Futur",
        prenom: "Coach",
        dateNaissance: DateTime.now().add(Duration(days: 365)),
        telephone: "0000000000",
        email: "futur.coach@example.com",
        adresse: "123 Futur Street",
        nationalite: "Inconnue",
        numeroPasseport: "XX000000",
        numeroIdentite: "ID000000",
        specialite: "Vision",
        licenceEntraineur: "Licence Inconnue",
        niveauResponsabilite: 1,
      );

      await box.put('entraineur3', entraineur);

      final fromHive = box.get('entraineur3');

      expect(fromHive!.dateNaissance.isAfter(DateTime.now()), isTrue);

      await box.close();
    });
  });
}
