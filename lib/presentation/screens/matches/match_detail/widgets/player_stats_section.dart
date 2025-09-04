// lib/presentation/screens/matches/widgets/player_stats_section.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/match.dart';

class PlayerStatsSection extends StatelessWidget {
  final Match match;
  final PlayerProvider playerProvider;

  const PlayerStatsSection({
    super.key,
    required this.match,
    required this.playerProvider,
  });

  Color _getRatingColor(double rating) {
    if (rating >= 8.0) return AppColors.excellent;
    if (rating >= 7.0) return AppColors.good;
    if (rating >= 6.0) return AppColors.average;
    return AppColors.poor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistiques des joueurs',
            style: AppTextStyles.heading5,
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          ...match.playerStats!.entries.map((entry) {
            final player = playerProvider.getPlayerById(entry.key);
            final stats = entry.value;
            
            if (player == null) return const SizedBox.shrink();
            
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      player.name,
                      style: AppTextStyles.body1,
                    ),
                  ),
                  if (stats.goals > 0) ...[
                    const Icon(Icons.sports_soccer, size: 16, color: AppColors.primary),
                    Text('${stats.goals}', style: AppTextStyles.caption),
                    const SizedBox(width: 8),
                  ],
                  if (stats.assists > 0) ...[
                    const Icon(Icons.trending_up, size: 16, color: AppColors.secondary),
                    Text('${stats.assists}', style: AppTextStyles.caption),
                    const SizedBox(width: 8),
                  ],
                  if (stats.yellowCards > 0) ...[
                    Container(
                      width: 12,
                      height: 16,
                      color: Colors.yellow,
                    ),
                    Text('${stats.yellowCards}', style: AppTextStyles.caption),
                    const SizedBox(width: 8),
                  ],
                  if (stats.redCards > 0) ...[
                    Container(
                      width: 12,
                      height: 16,
                      color: Colors.red,
                    ),
                    Text('${stats.redCards}', style: AppTextStyles.caption),
                  ],
                  Expanded(
                    child: Text(
                      '${stats.rating}',
                      style: AppTextStyles.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getRatingColor(stats.rating),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}