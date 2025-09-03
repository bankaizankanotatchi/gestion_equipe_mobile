import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../providers/match_provider.dart';
import 'match_cards/upcoming_match_card.dart';
import 'empty_state_widget.dart';

class UpcomingMatchesTab extends StatelessWidget {
  const UpcomingMatchesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final upcomingMatches = matchProvider.upcomingMatches;

        if (upcomingMatches.isEmpty) {
          return const EmptyStateWidget(
            message: 'Aucun match programmé',
            icon: Icons.event,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          itemCount: upcomingMatches.length,
          itemBuilder: (context, index) {
            return UpcomingMatchCard(match: upcomingMatches[index]);
          },
        );
      },
    );
  }
}