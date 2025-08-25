
// lib/data/repositories/player_repository.dart
import '../models/player.dart';
import '../database/mock_database.dart';

class PlayerRepository {
  final MockDatabase _database = MockDatabase.instance;

  Future<List<Player>> getAllPlayers() async {
    return _database.players;
  }

  Future<Player?> getPlayerById(String id) async {
    return _database.getPlayerById(id);
  }

  Future<List<Player>> getPlayersByPosition(Position position) async {
    return _database.getPlayersByPosition(position);
  }

  Future<List<Player>> getActivePlayersSortedByRating() async {
    return _database.getActivePlayersSortedByRating();
  }

  Future<bool> addPlayer(Player player) async {
    try {
      _database.addPlayer(player);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePlayer(Player player) async {
    try {
      _database.updatePlayer(player);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePlayer(String playerId) async {
    try {
      _database.deletePlayer(playerId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getTopScorers() async {
    return _database.getTopScorers();
  }

  Future<List<Map<String, dynamic>>> getTopAssists() async {
    return _database.getTopAssists();
  }
}