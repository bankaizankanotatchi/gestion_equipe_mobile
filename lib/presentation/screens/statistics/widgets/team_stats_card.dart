// lib/presentation/screens/statistics/components/team_stats_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import './stat_item_fifa.dart';
import './goals_progress_bar.dart';

class TeamStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final stats = matchProvider.getTeamStatistics();
        
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'STATISTIQUES ÉQUIPE',
                        style: AppTextStyles.subtitle2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                
                // Première ligne de stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatItemFIFA(
                      value: '${stats['matchesPlayed']}',
                      label: 'MATCHS',
                      icon: Icons.sports_soccer,
                      color:  AppColors.primary,
                    ),
                    StatItemFIFA(
                      value: '${stats['points']}',
                      label: 'POINTS',
                      icon: Icons.star,
                      color: Colors.amber,
                    ),
                    StatItemFIFA(
                      value: '${stats['goalsFor']}',
                      label: 'BUTS POUR',
                      icon: Icons.sports_score,
                      color: AppColors.excellent,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                
                // Deuxième ligne de stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatItemFIFA(
                      value: '${stats['wins']}',
                      label: 'VICTOIRES',
                      icon: Icons.emoji_events,
                      color: AppColors.win,
                    ),
                    StatItemFIFA(
                      value: '${stats['draws']}',
                      label: 'MATCHS NULS',
                      icon: Icons.horizontal_rule,
                      color: AppColors.draw,
                    ),
                    StatItemFIFA(
                      value: '${stats['losses']}',
                      label: 'DÉFAITES',
                      icon: Icons.close,
                      color: AppColors.loss,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                
                // Barre de progression buts pour/contre
                GoalsProgressBar(
                  goalsFor: stats['goalsFor'],
                  goalsAgainst: stats['goalsAgainst'],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

