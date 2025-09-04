// lib/presentation/screens/home/widgets/dashboard/quick_stats_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../../providers/player_provider.dart';
import '../../../../providers/match_provider.dart';
import 'stat_card.dart';

class QuickStatsSection extends StatelessWidget {
  const QuickStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlayerProvider, MatchProvider>(
      builder: (context, playerProvider, matchProvider, child) {
        final stats = matchProvider.getTeamStatistics();
        final activePlayers = playerProvider.activePlayers;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Statistiques rapides',
                  style: AppTextStyles.heading4,
                ),
                TextButton(
                  onPressed: () {
                    context.router.push(const StatisticsRoute());
                  },
                  child: Text(
                    'Voir plus',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Joueurs actifs',
                    value: '${activePlayers.length}',
                    icon: Icons.group,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: StatCard(
                    title: 'Matchs joués',
                    value: '${stats['matchesPlayed']}',
                    icon: Icons.sports_soccer,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Victoires',
                    value: '${stats['wins']}',
                    icon: Icons.emoji_events,
                    color: AppColors.excellent,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: StatCard(
                    title: 'Buts marqués',
                    value: '${stats['goalsFor']}',
                    icon: Icons.sports_score,
                    color: AppColors.info,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}