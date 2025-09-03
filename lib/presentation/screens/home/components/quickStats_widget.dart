import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../providers/match_provider.dart';
import '../../../providers/player_provider.dart';
import '../../statistics/statistics_screen.dart';

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StatisticsScreen(),
                      ),
                    );
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
                  child: _buildStatCard(
                    'Joueurs actifs',
                    '${activePlayers.length}',
                    Icons.group,
                    AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: _buildStatCard(
                    'Matchs joués',
                    '${stats['matchesPlayed']}',
                    Icons.sports_soccer,
                    AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Victoires',
                    '${stats['wins']}',
                    Icons.emoji_events,
                    AppColors.excellent,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: _buildStatCard(
                    'Buts marqués',
                    '${stats['goalsFor']}',
                    Icons.sports_score,
                    AppColors.info,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: AppConstants.iconSizeMedium,
              ),
              const Spacer(),
              Text(
                value,
                style: AppTextStyles.heading3.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}