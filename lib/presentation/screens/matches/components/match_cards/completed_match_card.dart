import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../data/models/match.dart';

class CompletedMatchCard extends StatelessWidget {
  final Match match;

  const CompletedMatchCard({
    super.key,
    required this.match,
  });

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
          color: _getResultBorderColor(result.outcome),
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
                _formatMatchDate(match.dateTime),
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
                        _buildTeamLogo(true),
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
                          color: _getResultColor(result.outcome),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getResultBackgroundColor(result.outcome),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getResultText(result.outcome),
                          style: AppTextStyles.caption.copyWith(
                            color: _getResultColor(result.outcome),
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
                        _buildTeamLogo(false),
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

  Widget _buildTeamLogo(bool isHomeTeam) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isHomeTeam ? Colors.transparent : Colors.grey.shade300,
        border: Border.all(
          color: isHomeTeam ? Colors.transparent : Colors.grey.shade400,
          width: 2,
        ),
        image: isHomeTeam
            ? const DecorationImage(
          image: AssetImage('assets/logos/logo.png'),
          fit: BoxFit.cover,
        )
            : null,
      ),
      child: isHomeTeam
          ? null
          : Center(
        child: Text(
          'A',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Color _getResultColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win;
      case MatchOutcome.draw:
        return AppColors.draw;
      case MatchOutcome.loss:
        return AppColors.loss;
    }
  }

  Color _getResultBackgroundColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win.withOpacity(0.1);
      case MatchOutcome.draw:
        return AppColors.draw.withOpacity(0.1);
      case MatchOutcome.loss:
        return AppColors.loss.withOpacity(0.1);
    }
  }

  Color _getResultBorderColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win.withOpacity(0.3);
      case MatchOutcome.draw:
        return AppColors.draw.withOpacity(0.3);
      case MatchOutcome.loss:
        return AppColors.loss.withOpacity(0.3);
    }
  }

  String _getResultText(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return 'Victoire';
      case MatchOutcome.draw:
        return 'Nul';
      case MatchOutcome.loss:
        return 'Défaite';
    }
  }

  String _formatMatchDate(DateTime dateTime) {
    final months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }
}