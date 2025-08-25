// lib/presentation/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class AuthProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  
  User? _currentUser;
  bool _isLoading = true;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  bool get isCoach => _currentUser?.type == UserType.coach;
  bool get isPlayer => _currentUser?.type == UserType.player;

  AuthProvider() {
    _initAuth();
  }

  Future<void> _initAuth() async {
    _isLoading = true;
    notifyListeners();
    
    // Vérifier si un utilisateur est déjà connecté
    final savedUser = await _userRepository.getCurrentUser();
    if (savedUser != null) {
      _currentUser = savedUser;
      _isAuthenticated = true;
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _userRepository.login(email, password);
      if (user != null) {
        _currentUser = user;
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Erreur de connexion: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    await _userRepository.logout();
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> updateProfile(User updatedUser) async {
    try {
      final success = await _userRepository.updateUser(updatedUser);
      if (success) {
        _currentUser = updatedUser;
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('Erreur mise à jour profil: $e');
      return false;
    }
  }

   Future<User?> getUserById(String userId) async {
    try {
      return await _userRepository.getUserById(userId);
    } catch (e) {
      debugPrint('Erreur getUserById: $e');
      return null;
    }
  }
}