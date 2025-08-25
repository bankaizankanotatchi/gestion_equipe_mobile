// lib/data/repositories/user_repository.dart
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../database/mock_database.dart';

class UserRepository {
  final MockDatabase _database = MockDatabase.instance;
  static const String _currentUserKey = 'current_user_id';

  Future<User?> login(String email, String password) async {
    final user = _database.getUserByEmail(email);
    
    if (user != null && user.password == password) {
      // Sauvegarder l'utilisateur connecté
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currentUserKey, user.id);
      return user;
    }
    
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_currentUserKey);
    
    if (userId != null) {
      return _database.getUserById(userId);
    }
    
    return null;
  }

  Future<bool> updateUser(User user) async {
    try {
      // Dans une vraie app, on mettrait à jour la base de données
      // Ici on simule juste un succès
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> getAllUsers() async {
    return _database.users;
  }

  Future<List<User>> getUsersByType(UserType type) async {
    return _database.getUsersByType(type);
  }

  User? getUserById(String id) {
    return _database.getUserById(id);
  }
}
