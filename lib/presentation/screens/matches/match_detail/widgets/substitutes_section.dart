// lib/presentation/screens/matches/widgets/substitutes_section.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/match.dart';

class SubstitutesSection extends StatelessWidget {
  final Match match;
  final PlayerProvider playerProvider;

  const SubstitutesSection({
    super.key,
    required this.match,
    required this.playerProvider,
  });

  String _getPositionAbbreviation(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'GB';
      case Position.defender:
        return 'DEF';
      case Position.midfielder:
        return 'MIL';
      case Position.forward:
        return 'ATT';
    }
  }

  Color _getPositionColor(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return AppColors.goalkeeper;
      case Position.defender:
        return AppColors.defender;
      case Position.midfielder:
        return AppColors.midfielder;
      case Position.forward:
        return AppColors.forward;
    }
  }

  @override
  Widget build(BuildContext context) {
    final substitutes = match.substitutes!
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REMPLAÇANTS',
          style: AppTextStyles.subtitle1.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        Wrap(
          spacing: AppConstants.paddingSmall,
          runSpacing: AppConstants.paddingSmall,
          children: substitutes.map((player) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
                vertical: AppConstants.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _getPositionColor(player.position),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        player.jerseyNumber.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    player.name,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getPositionAbbreviation(player.position),
                    style: AppTextStyles.caption.copyWith(
                      color: _getPositionColor(player.position),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}