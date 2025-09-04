// lib/presentation/screens/home/widgets/dashboard/upcoming_matches_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/dashboard/empty_state.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../../providers/match_provider.dart';
import 'match_card.dart';

class UpcomingMatchesSection extends StatelessWidget {
  const UpcomingMatchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final upcomingMatches = matchProvider.upcomingMatches.take(3).toList();
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prochains matchs',
                  style: AppTextStyles.heading4,
                ),
                TextButton(
                  onPressed: () {
                    context.router.push(const MatchesRoute());
                  },
                  child: Text(
                    'Voir tout',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            if (upcomingMatches.isEmpty)
              EmptyStated(message: 'Aucun match programmé', onClearFilter: () {  },)
            else
              ...upcomingMatches.map((match) => MatchCard(match: match)),
          ],
        );
      },
    );
  }
}