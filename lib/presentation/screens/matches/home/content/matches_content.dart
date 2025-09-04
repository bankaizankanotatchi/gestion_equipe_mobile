// lib/presentation/screens/matches/content/matches_content.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/matches/home/widgets/completed_match_card.dart';
import 'package:team_manager_app/presentation/screens/matches/home/widgets/empty_state.dart';
import 'package:team_manager_app/presentation/screens/matches/home/widgets/upcoming_match_card.dart';
import '../../../../providers/match_provider.dart';

class UpcomingMatchesTab extends StatelessWidget {
  const UpcomingMatchesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final upcomingMatches = matchProvider.upcomingMatches;

        if (upcomingMatches.isEmpty) {
          return const EmptyState(
            message: 'Aucun match programmé', 
            icon: Icons.history_edu,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: upcomingMatches.length,
          itemBuilder: (context, index) {
            return UpcomingMatchCard(match: upcomingMatches[index]);
          },
        );
      },
    );
  }
}

class CompletedMatchesTab extends StatelessWidget {
  const CompletedMatchesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final completedMatches = matchProvider.completedMatches;

        if (completedMatches.isEmpty) {
          return const EmptyState(
            message: 'Aucun match terminé',
            icon: Icons.sports_soccer,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: completedMatches.length,
          itemBuilder: (context, index) {
            return CompletedMatchCard(match: completedMatches[index]);
          },
        );
      },
    );
  }
}