// lib/presentation/screens/matches/widgets/formation_info.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/match.dart';

class FormationInfo extends StatelessWidget {
  final Match match;
  final PlayerProvider playerProvider;

  const FormationInfo({
    super.key,
    required this.match,
    required this.playerProvider,
  });

  String _detectFormation(List<Player> players) {
    int defenders = players.where((p) => p.position == Position.defender).length;
    int midfielders = players.where((p) => p.position == Position.midfielder).length;
    int forwards = players.where((p) => p.position == Position.forward).length;
    
    // Formations classiques
    if (defenders == 4 && midfielders == 4 && forwards == 2) return '4-4-2';
    if (defenders == 4 && midfielders == 3 && forwards == 3) return '4-3-3';
    if (defenders == 4 && midfielders == 2 && forwards == 4) return '4-2-4';
    if (defenders == 3 && midfielders == 5 && forwards == 2) return '3-5-2';
    if (defenders == 3 && midfielders == 4 && forwards == 3) return '3-4-3';
    if (defenders == 5 && midfielders == 3 && forwards == 2) return '5-3-2';
    if (defenders == 5 && midfielders == 4 && forwards == 1) return '5-4-1';
    if (defenders == 4 && midfielders == 1 && forwards == 5) return '4-1-5';
    if (defenders == 3 && midfielders == 3 && forwards == 4) return '3-3-4';
    
    return '$defenders-$midfielders-$forwards';
  }

  @override
  Widget build(BuildContext context) {
    final startingPlayers = match.startingEleven!
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();
    
    final formation = _detectFormation(startingPlayers);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLarge,
          vertical: AppConstants.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Text(
          'FORMATION: $formation',
          style: AppTextStyles.subtitle1.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}