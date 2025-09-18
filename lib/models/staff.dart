import 'package:hive/hive.dart';
import 'personne.dart';
import 'enums/role_staff.dart';

part 'staff.g.dart';

@HiveType(typeId: 4)
class Staff extends Personne {
  @HiveField(10)
  RoleStaff role;

  @HiveField(11)
  String specialite;

  @HiveField(12)
  String certification;

  @HiveField(13)
  int experience;

  Staff({
    required int id,
    required String nom,
    required String prenom,
    required DateTime dateNaissance,
    required String telephone,
    required String email,
    required String adresse,
    required String nationalite,
    required String numeroPasseport,
    required String numeroIdentite,
    required this.role,
    required this.specialite,
    required this.certification,
    required this.experience,
  }) : super(
          id: id,
          nom: nom,
          prenom: prenom,
          dateNaissance: dateNaissance,
          telephone: telephone,
          email: email,
          adresse: adresse,
          nationalite: nationalite,
          numeroPasseport: numeroPasseport,
          numeroIdentite: numeroIdentite,
        );
}
