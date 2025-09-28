import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:team_manager_app/models/analyste_video.dart';
import 'package:team_manager_app/models/staff.dart';
import 'package:team_manager_app/models/enums/role_staff.dart';

void main() {
  setUpAll(() {
    // Initialisation du chemin pour Hive
    Hive.init('./hive_testing_path');

    // 🔹 Enregistrement des adapters Hive
    Hive.registerAdapter(AnalysteVideoAdapter());
    Hive.registerAdapter(StaffAdapter());
    Hive.registerAdapter(RoleStaffAdapter());
  });

  test('AnalysteVideo - sauvegarde et lecture Hive', () async {
    final box = await Hive.openBox<AnalysteVideo>('analysteVideoBoxTest');

    // 📌 Création d’un AnalysteVideo
    final analyste = AnalysteVideo(
      id: 1,
      nom: 'Dupont',
      prenom: 'Alice',
      dateNaissance: DateTime(1990, 3, 15),
      telephone: '0612345678',
      email: 'alice.dupont@test.com',
      adresse: '45 rue de Paris',
      nationalite: 'FR',
      numeroPasseport: 'FR123456',
      numeroIdentite: 'ID987654',
      role: RoleStaff.analysteVideo,
      specialite: 'Analyse tactique',
      certification: 'UEFA Licence Analyste',
      experience: 8,
      logicielsUtilises: ['Hudl', 'NacSport', 'Dartfish'],
    );

    // ✅ Sauvegarde
    await box.put('analyste1', analyste);

    // ✅ Lecture
    final fromHive = box.get('analyste1');

    expect(fromHive, isNotNull);
    expect(fromHive!.nom, equals('Dupont'));
    expect(fromHive.prenom, equals('Alice'));
    expect(fromHive.role, equals(RoleStaff.analysteVideo));
    expect(fromHive.logicielsUtilises, contains('Hudl'));

    await box.close();
  });

  test('AnalysteVideo - mise à jour', () async {
    final box = await Hive.openBox<AnalysteVideo>('analysteVideoBoxTest');

    var analyste = box.get('analyste1');
    expect(analyste, isNotNull);

    // 🔹 Mise à jour des données
    analyste!.experience = 10;
    analyste.logicielsUtilises.add('Sportscode');
    await analyste.save();

    final updated = box.get('analyste1');
    expect(updated!.experience, equals(10));
    expect(updated.logicielsUtilises, contains('Sportscode'));

    await box.close();
  });

  test('AnalysteVideo - suppression', () async {
    final box = await Hive.openBox<AnalysteVideo>('analysteVideoBoxTest');

    // 🔹 Suppression de l'entrée
    await box.delete('analyste1');
    final deleted = box.get('analyste1');

    expect(deleted, isNull);

    await box.close();
  });
}
