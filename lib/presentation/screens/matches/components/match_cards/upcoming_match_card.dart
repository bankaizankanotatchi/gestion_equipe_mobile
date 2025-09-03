import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../data/models/match.dart';

class UpcomingMatchCard extends StatelessWidget {
  final Match match;

  const UpcomingMatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
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
      ),
      child: InkWell(
        onTap: () {
          context.router.push(MatchDetailRoute(matchId: match.id));
        },
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            children: [
              // Date et heure
              Text(
                _formatMatchDate(match.dateTime),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _formatMatchTime(match.dateTime),
                style: AppTextStyles.subtitle2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Contenu du match
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Équipe locale (notre équipe)
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

                  // VS et informations
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'VS',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match.venue,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Programmé',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
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

  String _formatMatchDate(DateTime dateTime) {
    final months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }

  String _formatMatchTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}