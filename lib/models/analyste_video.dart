import 'package:hive/hive.dart';
import 'package:team_manager_app/models/enums/role_staff.dart';
import 'staff.dart';

part 'analyste_video.g.dart';

@HiveType(typeId: 7)
class AnalysteVideo extends Staff {
  @HiveField(14)
  List<String> logicielsUtilises;

  AnalysteVideo({
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
    required RoleStaff role,
    required String specialite,
    required String certification,
    required int experience,
    required this.logicielsUtilises,
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
          role: role,
          specialite: specialite,
          certification: certification,
          experience: experience,
        );
}
