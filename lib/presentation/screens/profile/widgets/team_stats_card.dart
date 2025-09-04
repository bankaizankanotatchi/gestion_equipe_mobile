// lib/presentation/screens/profile/components/team_stats_card.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import './stat_card.dart';

class TeamStatsCards extends StatelessWidget {
  final MatchProvider matchProvider;

  const TeamStatsCards({
    super.key,
    required this.matchProvider,
  });

  @override
  Widget build(BuildContext context) {
    final teamStats = matchProvider.getTeamStatistics();

    // Assurez-vous que toutes les clés existent
    final matchesPlayed = teamStats['matchesPlayed'] ?? 0;
    final wins = teamStats['wins'] ?? 0;
    final draws = teamStats['draws'] ?? 0;
    final losses = teamStats['losses'] ?? 0;
    final goalsFor = teamStats['goalsFor'] ?? 0;
    final goalsAgainst = teamStats['goalsAgainst'] ?? 0;

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
              'STATISTIQUES DE L\'ÉQUIPE',
              style: AppTextStyles.heading5.copyWith(
                color:  AppColors.primary, // Remplacez par AppColors.primary
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            LayoutBuilder(
              builder: (context, constraints) {
                // Déterminer le nombre de colonnes en fonction de la largeur
                final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppConstants.paddingSmall,
                  mainAxisSpacing: AppConstants.paddingSmall,
                  childAspectRatio: constraints.maxWidth > 600 ? 1.5 : 2.2,
                  children: [
                    StatCard(
                      title: 'Matchs',
                      value: '$matchesPlayed',
                      icon: Icons.sports_soccer,
                      context: context,
                    ),
                    StatCard(
                      title: 'Victoires',
                      value: '$wins',
                      icon: Icons.emoji_events,
                      context: context,
                      color: Colors.green,
                    ),
                    StatCard(
                      title: 'Nuls',
                      value: '$draws',
                      icon: Icons.horizontal_rule,
                      context: context,
                      color: Colors.orange,
                    ),
                    StatCard(
                      title: 'Défaites',
                      value: '$losses',
                      icon: Icons.close,
                      context: context,
                      color: Colors.red,
                    ),
                    StatCard(
                      title: 'Buts pour',
                      value: '$goalsFor',
                      icon: Icons.sports_score,
                      context: context,
                      color:  AppColors.primary,
                    ),
                    StatCard(
                      title: 'Buts contre',
                      value: '$goalsAgainst',
                      icon: Icons.shield,
                      context: context,
                      color: Colors.purple,
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
}