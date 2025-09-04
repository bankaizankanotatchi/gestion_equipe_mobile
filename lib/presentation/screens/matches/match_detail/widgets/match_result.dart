// lib/presentation/screens/matches/widgets/match_result.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/data/models/match.dart';

class MatchResults extends StatelessWidget {
  final Match match;

  const MatchResults({super.key, required this.match});

  String _getResultText(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return 'VICTOIRE';
      case MatchOutcome.draw:
        return 'MATCH NUL';
      case MatchOutcome.loss:
        return 'DÉFAITE';
    }
  }

  Color _getResultColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.accent;
      case MatchOutcome.draw:
        return AppColors.warning;
      case MatchOutcome.loss:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (match.result == null) return const SizedBox.shrink();

    final result = match.result!;
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
            'Résultat',
            style: AppTextStyles.heading5,
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    result.isHomeTeam ? 'Notre équipe' : match.opponent,
                    style: AppTextStyles.body1,
                  ),
                  Text(
                    result.isHomeTeam ? result.homeScore.toString() : result.awayScore.toString(),
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '-',
                style: AppTextStyles.heading2,
              ),
              Column(
                children: [
                  Text(
                    result.isHomeTeam ? match.opponent : 'Notre équipe',
                    style: AppTextStyles.body1,
                  ),
                  Text(
                    result.isHomeTeam ? result.awayScore.toString() : result.homeScore.toString(),
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
                vertical: AppConstants.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: _getResultColor(result.outcome),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Text(
                _getResultText(result.outcome),
                style: AppTextStyles.subtitle2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (match.manOfTheMatch != null) ...[
            const SizedBox(height: AppConstants.paddingMedium),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Homme du match: ${match.manOfTheMatch}',
                  style: AppTextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}