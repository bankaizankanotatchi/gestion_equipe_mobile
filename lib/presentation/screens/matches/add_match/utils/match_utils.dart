// lib/presentation/screens/matches/utils/match_utils.dart
import 'package:flutter/material.dart';
import '../add_match_screen.dart';

class MatchUtils {
  static IconData getMatchTypeIcon(MatchType type) {
    switch (type) {
      case MatchType.friendly: return Icons.handshake;
      case MatchType.championship: return Icons.emoji_events;
      case MatchType.cup: return Icons.military_tech;
      case MatchType.tournament: return Icons.emoji_events;
    }
  }

  static String getMatchTypeName(MatchType type) {
    switch (type) {
      case MatchType.friendly: return 'Match Amical';
      case MatchType.championship: return 'Championnat';
      case MatchType.cup: return 'Coupe';
      case MatchType.tournament: return 'Tournoi';
    }
  }

  static String getMatchTypeDescription(MatchType type) {
    switch (type) {
      case MatchType.friendly: return 'Match d\'entraînement sans enjeu';
      case MatchType.championship: return 'Match de championnat officiel';
      case MatchType.cup: return 'Match à élimination directe';
      case MatchType.tournament: return 'Match de tournoi';
    }
  }
}