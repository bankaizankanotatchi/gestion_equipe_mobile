
// lib/data/repositories/match_repository.dart
import '../models/match.dart';
import '../database/mock_database.dart';

class MatchRepository {
  final MockDatabase _database = MockDatabase.instance;

  Future<List<Match>> getAllMatches() async {
    return _database.matches;
  }

  Future<Match?> getMatchById(String id) async {
    return _database.getMatchById(id);
  }

  Future<List<Match>> getCompletedMatches() async {
    return _database.getCompletedMatches();
  }

  Future<List<Match>> getUpcomingMatches() async {
    return _database.getUpcomingMatches();
  }

  Future<bool> addMatch(Match match) async {
    try {
      _database.addMatch(match);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateMatch(Match match) async {
    try {
      _database.updateMatch(match);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMatch(String matchId) async {
    try {
      _database.deleteMatch(matchId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> getTeamStatistics() {
    return _database.getTeamStatistics();
  }

  List<Map<String, dynamic>> getTopAssists() {
    return _database.getTopAssists();
  }

  List<Map<String, dynamic>> getTopScorers() {
    return _database.getTopScorers();
  }
}