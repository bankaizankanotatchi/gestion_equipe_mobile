// lib/presentation/screens/matches/utils/formation_utils.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/player.dart';

class FormationUtils {
  static String detectFormation(List<String> startingEleven, BuildContext context) {
    if (startingEleven.length != 11) return 'Non définie';
    
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    final startingPlayers = startingEleven
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();

    int defenders = startingPlayers.where((p) => p.position == Position.defender).length;
    int midfielders = startingPlayers.where((p) => p.position == Position.midfielder).length;
    int forwards = startingPlayers.where((p) => p.position == Position.forward).length;
    
    if (defenders == 4 && midfielders == 4 && forwards == 2) return '4-4-2';
    if (defenders == 4 && midfielders == 3 && forwards == 3) return '4-3-3';
    if (defenders == 3 && midfielders == 5 && forwards == 2) return '3-5-2';
    if (defenders == 3 && midfielders == 4 && forwards == 3) return '3-4-3';
    if (defenders == 5 && midfielders == 3 && forwards == 2) return '5-3-2';
    if (defenders == 4 && midfielders == 5 && forwards == 1) return '4-5-1';
    
    return '$defenders-$midfielders-$forwards';
  }
}