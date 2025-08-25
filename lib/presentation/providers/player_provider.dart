
// lib/presentation/providers/player_provider.dart
import 'package:flutter/foundation.dart';
import '../../data/models/player.dart';
import '../../data/repositories/player_repository.dart';

class PlayerProvider with ChangeNotifier {
  final PlayerRepository _repository = PlayerRepository();
  
  List<Player> _players = [];
  bool _isLoading = false;
  String? _error;

  List<Player> get players => _players;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Player> get activePlayers => 
    _players.where((p) => p.isActive).toList();
  
  List<Player> get goalkeepers => 
    _players.where((p) => p.position == Position.goalkeeper && p.isActive).toList();
  
  List<Player> get defenders => 
    _players.where((p) => p.position == Position.defender && p.isActive).toList();
  
  List<Player> get midfielders => 
    _players.where((p) => p.position == Position.midfielder && p.isActive).toList();
  
  List<Player> get forwards => 
    _players.where((p) => p.position == Position.forward && p.isActive).toList();

  PlayerProvider() {
    loadPlayers();
  }

  Future<void> loadPlayers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _players = await _repository.getAllPlayers();
    } catch (e) {
      _error = e.toString();
      debugPrint('Erreur chargement joueurs: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addPlayer(Player player) async {
    try {
      final success = await _repository.addPlayer(player);
      if (success) {
        _players.add(player);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePlayer(Player player) async {
    try {
      final success = await _repository.updatePlayer(player);
      if (success) {
        final index = _players.indexWhere((p) => p.id == player.id);
        if (index != -1) {
          _players[index] = player;
          notifyListeners();
        }
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deletePlayer(String playerId) async {
    try {
      final success = await _repository.deletePlayer(playerId);
      if (success) {
        _players.removeWhere((p) => p.id == playerId);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Player? getPlayerById(String id) {
    try {
      return _players.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Player> getPlayersSortedByRating() {
    final sortedPlayers = List<Player>.from(_players);
    sortedPlayers.sort((a, b) => b.overallRating.compareTo(a.overallRating));
    return sortedPlayers;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}