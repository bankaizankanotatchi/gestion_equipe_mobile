// lib/presentation/screens/statistics/content/statistics_content.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/screens/statistics/widgets/player_list_card.dart';
import 'package:team_manager_app/presentation/screens/statistics/widgets/team_stats_card.dart';
import '../../../providers/match_provider.dart';
import '../../../providers/player_provider.dart';

class StatisticsContent extends StatelessWidget {
  const StatisticsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary,
            AppColors.surface,
          ],
          stops: [0.1, 0.3],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             TeamStatsCard(),
            const SizedBox(height: AppConstants.paddingLarge),
            Consumer2<MatchProvider, PlayerProvider>(
              builder: (context, matchProvider, playerProvider, child) {
                final topScorers = matchProvider.getTopScorers();
                return PlayerListCard(
                  title: 'MEILLEURS BUTEURS',
                  icon: Icons.emoji_events,
                  emptyMessage: 'Aucun buteur pour le moment',
                  players: topScorers.take(5).toList(),
                  statBuilder: (scorer) => '${scorer['goals']} buts',
                  positionColor: AppColors.forward,
                );
              },
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            Consumer2<MatchProvider, PlayerProvider>(
              builder: (context, matchProvider, playerProvider, child) {
                final topAssists = matchProvider.getTopAssists();
                return PlayerListCard(
                  title: 'MEILLEURS PASSEURS',
                  icon: Icons.assistant,
                  emptyMessage: 'Aucune passe décisive pour le moment',
                  players: topAssists.take(5).toList(),
                  statBuilder: (assister) => '${assister['assists']} passes',
                  positionColor: AppColors.midfielder,
                );
              },
            ),
            const SizedBox(height: AppConstants.paddingLarge),
          ],
        ),
      ),
    );
  }
}