import 'package:hive/hive.dart';
import 'personne.dart';

part 'entraineur_adjoint.g.dart';

@HiveType(typeId: 21)
class EntraineurAdjoint extends Personne {
  @HiveField(10)
  String specialite;

  @HiveField(11)
  String licenceEntraineur;

  @HiveField(12)
  int niveauResponsabilite;

  EntraineurAdjoint({
    required super.id,
    required super.nom,
    required super.prenom,
    required super.dateNaissance,
    required super.telephone,
    required super.email,
    required super.adresse,
    required super.nationalite,
    required super.numeroPasseport,
    required super.numeroIdentite,
    required this.specialite,
    required this.licenceEntraineur,
    required this.niveauResponsabilite,
  });
}
