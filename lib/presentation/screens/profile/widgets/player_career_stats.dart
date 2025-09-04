// lib/presentation/screens/profile/components/player_career_stats.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/player.dart';
import './stat_card.dart';

class PlayerCareerStats extends StatelessWidget {
  final Player player;
  final MatchProvider matchProvider;

  const PlayerCareerStats({
    super.key,
    required this.player,
    required this.matchProvider,
  });

  @override
  Widget build(BuildContext context) {
    final playerStats = _getPlayerCompleteStats(player.id, matchProvider);
    final matchStats = _getPlayerMatchStats(player.id, matchProvider);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STATISTIQUES DE CARRIÈRE',
              style: AppTextStyles.heading5.copyWith(
                color:  AppColors.primary, // Remplacez par AppColors.primary
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            LayoutBuilder(
              builder: (context, constraints) {
                // Déterminer le nombre de colonnes en fonction de la largeur
                final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                final childAspectRatio = constraints.maxWidth > 600 ? 1.5 : 2.2;
                
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppConstants.paddingSmall,
                  mainAxisSpacing: AppConstants.paddingSmall,
                  childAspectRatio: childAspectRatio,
                  children: [
                    StatCard(
                      title: 'Matchs joués',
                      value: '${matchStats['matchesPlayed']}',
                      icon: Icons.sports_soccer,
                      context: context,
                    ),
                    StatCard(
                      title: 'Buts',
                      value: '${playerStats['goals']}',
                      icon: Icons.sports_score,
                      context: context,
                    ),
                    StatCard(
                      title: 'Passes D',
                      value: '${playerStats['assists']}',
                      icon: Icons.assistant,
                      context: context,
                    ),
                    StatCard(
                      title: 'Titularisations',
                      value: '${matchStats['starting']}',
                      icon: Icons.star,
                      context: context,
                    ),
                    StatCard(
                      title: 'Cartons J',
                      value: '${playerStats['yellowCards']}',
                      icon: Icons.warning,
                      context: context,
                      color: Colors.orange,
                    ),
                    StatCard(
                      title: 'Cartons R',
                      value: '${playerStats['redCards']}',
                      icon: Icons.block,
                      context: context,
                      color: Colors.red,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getPlayerCompleteStats(String playerId, MatchProvider matchProvider) {
    final matches = matchProvider.completedMatches;
    int goals = 0;
    int assists = 0;
    int yellowCards = 0;
    int redCards = 0;

    for (final match in matches) {
      if (match.playerStats != null && match.playerStats!.containsKey(playerId)) {
        final stats = match.playerStats![playerId]!;
        goals += stats.goals;
        assists += stats.assists;
        yellowCards += stats.yellowCards;
        redCards += stats.redCards;
      }
    }

    return {
      'goals': goals,
      'assists': assists,
      'yellowCards': yellowCards,
      'redCards': redCards,
    };
  }

  Map<String, dynamic> _getPlayerMatchStats(String playerId, MatchProvider matchProvider) {
    final matches = matchProvider.completedMatches;
    int matchesPlayed = 0;
    int starting = 0;

    for (final match in matches) {
      if (match.selectedPlayers != null && match.selectedPlayers!.contains(playerId)) {
        matchesPlayed++;
        if (match.startingEleven != null && match.startingEleven!.contains(playerId)) {
          starting++;
        }
      }
    }

    return {
      'matchesPlayed': matchesPlayed,
      'starting': starting,
      'substitute': matchesPlayed - starting,
    };
  }
}