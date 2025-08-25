
// lib/presentation/providers/match_provider.dart
import 'package:flutter/foundation.dart';
import '../../data/models/match.dart';
import '../../data/repositories/match_repository.dart';

class MatchProvider with ChangeNotifier {
  final MatchRepository _repository = MatchRepository();
  
  List<Match> _matches = [];
  bool _isLoading = false;
  String? _error;

  List<Match> get matches => _matches;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Match> get completedMatches => 
    _matches.where((m) => m.status == MatchStatus.completed)
           .toList()
           ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  
  List<Match> get upcomingMatches => 
    _matches.where((m) => m.status == MatchStatus.scheduled)
           .toList()
           ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

  MatchProvider() {
    loadMatches();
  }

  Future<void> loadMatches() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _matches = await _repository.getAllMatches();
    } catch (e) {
      _error = e.toString();
      debugPrint('Erreur chargement matchs: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addMatch(Match match) async {
    try {
      final success = await _repository.addMatch(match);
      if (success) {
        _matches.add(match);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateMatch(Match match) async {
    try {
      final success = await _repository.updateMatch(match);
      if (success) {
        final index = _matches.indexWhere((m) => m.id == match.id);
        if (index != -1) {
          _matches[index] = match;
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

  Future<bool> deleteMatch(String matchId) async {
    try {
      final success = await _repository.deleteMatch(matchId);
      if (success) {
        _matches.removeWhere((m) => m.id == matchId);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Match? getMatchById(String id) {
    try {
      return _matches.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> getTeamStatistics() {
    return _repository.getTeamStatistics();
  }

  List<Map<String, dynamic>> getTopAssists() {
    return _repository.getTopAssists();
  }

  List<Map<String, dynamic>> getTopScorers() {
    return _repository.getTopScorers();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}