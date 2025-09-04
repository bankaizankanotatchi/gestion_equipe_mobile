// lib/presentation/screens/matches/widgets/team_composition.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'football_pitch.dart';
import 'formation_info.dart';
import 'substitutes_section.dart';
import 'position_legend.dart';
import 'package:team_manager_app/data/models/match.dart';

class TeamComposition extends StatelessWidget {
  final Match match;
  final PlayerProvider playerProvider;

  const TeamComposition({
    super.key,
    required this.match,
    required this.playerProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'COMPOSITION D\'ÉQUIPE',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Terrain de football avec les joueurs
          FootballPitch(match: match, playerProvider: playerProvider),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          // Formation détectée
          FormationInfo(match: match, playerProvider: playerProvider),
          
          const SizedBox(height: AppConstants.paddingMedium),
          
          // Légende des positions
          const PositionLegend(),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          // Remplaçants
          if (match.substitutes != null && match.substitutes!.isNotEmpty)
            SubstitutesSection(match: match, playerProvider: playerProvider),
        ],
      ),
    );
  }
}