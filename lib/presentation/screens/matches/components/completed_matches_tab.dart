import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../providers/match_provider.dart';
import 'match_cards/completed_match_card.dart';
import 'empty_state_widget.dart';

class CompletedMatchesTab extends StatelessWidget {
  const CompletedMatchesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final completedMatches = matchProvider.completedMatches;

        if (completedMatches.isEmpty) {
          return const EmptyStateWidget(
            message: 'Aucun match terminé',
            icon: Icons.history,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          itemCount: completedMatches.length,
          itemBuilder: (context, index) {
            return CompletedMatchCard(match: completedMatches[index]);
          },
        );
      },
    );
  }
}