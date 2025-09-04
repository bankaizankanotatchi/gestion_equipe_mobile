// lib/presentation/screens/profile/components/player_match_history.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/player.dart';
import '../../../../data/models/match.dart';
import './match_row.dart';

class PlayerMatchHistory extends StatelessWidget {
  final Player player;
  final MatchProvider matchProvider;

  const PlayerMatchHistory({
    super.key,
    required this.player,
    required this.matchProvider,
  });

  @override
  Widget build(BuildContext context) {
    final matches = _getPlayerMatches(player.id, matchProvider);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DERNIERS MATCHS',
              style: AppTextStyles.heading5.copyWith(
                color:  AppColors.primary, // Remplacez par AppColors.primary
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            ...matches.take(3).map((match) => MatchRow(match: match, playerId: player.id)),
          ],
        ),
      ),
    );
  }

  List<Match> _getPlayerMatches(String playerId, MatchProvider matchProvider) {
    return matchProvider.completedMatches
        .where((match) => match.selectedPlayers != null && match.selectedPlayers!.contains(playerId))
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }
}