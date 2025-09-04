// lib/presentation/screens/matches/widgets/completed_match_card.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'team_logo.dart';
import 'match_card_common.dart';
import 'package:team_manager_app/data/models/match.dart';

class CompletedMatchCard extends StatelessWidget {
  final Match match;

  const CompletedMatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final result = match.result!;
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: MatchCardCommon.getResultBorderColor(result.outcome),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          context.router.push(MatchDetailRoute(matchId: match.id));
        },
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            children: [
              // Date du match
              Text(
                MatchCardCommon.formatMatchDate(match.dateTime),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              // Score et équipes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Équipe locale
                  Expanded(
                    child: Column(
                      children: [
                        const TeamLogo(isHomeTeam: true),
                        const SizedBox(height: 8),
                        Text(
                          'Notre Équipe',
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  // Score
                  Column(
                    children: [
                      Text(
                        result.isHomeTeam
                            ? '${result.homeScore} - ${result.awayScore}'
                            : '${result.awayScore} - ${result.homeScore}',
                        style: AppTextStyles.heading3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: MatchCardCommon.getResultColor(result.outcome),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: MatchCardCommon.getResultBackgroundColor(result.outcome),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          MatchCardCommon.getResultText(result.outcome),
                          style: AppTextStyles.caption.copyWith(
                            color: MatchCardCommon.getResultColor(result.outcome),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Équipe adverse
                  Expanded(
                    child: Column(
                      children: [
                        const TeamLogo(isHomeTeam: false),
                        const SizedBox(height: 8),
                        Text(
                          match.opponent,
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Informations supplémentaires
              Text(
                match.venue,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                ),
              ),
              
              if (match.manOfTheMatch != null) ...[
                const SizedBox(height: 8),
                Text(
                  '⭐ Homme du match',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}