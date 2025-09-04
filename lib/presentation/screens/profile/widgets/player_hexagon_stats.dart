// lib/presentation/screens/profile/components/player_hexagon_stats.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/player.dart';
import './hexagon_stats_painter.dart';

class PlayerHexagonStats extends StatelessWidget {
  final Player player;

  const PlayerHexagonStats({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final stats = player.stats;
    final statValues = [
      stats.pace.toDouble(),
      stats.shooting.toDouble(),
      stats.passing.toDouble(),
      stats.dribbling.toDouble(),
      stats.defending.toDouble(),
      stats.physical.toDouble(),
    ];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          children: [
            Text(
              'CARACTÉRISTIQUES',
              style: AppTextStyles.heading5.copyWith(
                color:  AppColors.primary, // Remplacez par AppColors.primary
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: HexagonStatsPainter(statValues),
              ),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            Wrap(
              spacing: AppConstants.paddingSmall,
              runSpacing: AppConstants.paddingSmall,
              children: [
                _buildStatLegend('Vitesse', stats.pace, Colors.green),
                _buildStatLegend('Tir', stats.shooting, Colors.red),
                _buildStatLegend('Passes', stats.passing,  AppColors.primary),
                _buildStatLegend('Dribble', stats.dribbling, Colors.purple),
                _buildStatLegend('Défense', stats.defending, Colors.orange),
                _buildStatLegend('Physique', stats.physical, Colors.yellow),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatLegend(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: $value',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}