// lib/presentation/screens/profile/components/match_row.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/match.dart';

class MatchRow extends StatelessWidget {
  final Match match;
  final String playerId;

  const MatchRow({
    super.key,
    required this.match,
    required this.playerId,
  });

  @override
  Widget build(BuildContext context) {
    final playerStats = match.playerStats?[playerId];
    final isStarter = match.startingEleven != null && match.startingEleven!.contains(playerId);
    final result = match.result;
    final score = result != null
        ? '${result.isHomeTeam ? result.homeScore : result.awayScore}-${result.isHomeTeam ? result.awayScore : result.homeScore}'
        : 'N/A';

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'vs ${match.opponent}',
                  style: AppTextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatDate(match.dateTime),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isStarter ?  AppColors.primary : Colors.grey, // Remplacez par AppColors
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isStarter ? 'Titulaire' : 'Remplaçant',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: _getResultColor(match),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              score,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (playerStats != null) ...[
            const SizedBox(width: AppConstants.paddingSmall),
            _buildStatIndicator('⚽', playerStats.goals),
            _buildStatIndicator('🎯', playerStats.assists),
            _buildStatIndicator('⭐', playerStats.rating.round()),
          ],
        ],
      ),
    );
  }

  Widget _buildStatIndicator(String emoji, int value) {
    if (value == 0) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$emoji$value',
        style: AppTextStyles.caption.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    final difference = today.difference(messageDate).inDays;

    if (difference == 0) return 'Aujourd\'hui';
    if (difference == 1) return 'Hier';
    if (difference < 7) return 'Il y a $difference jours';

    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getResultColor(Match match) {
    if (match.result == null) return Colors.grey;

    switch (match.result!.outcome) {
      case 'win':
        return Colors.green; // Remplacez par AppColors.win
      case 'draw':
        return Colors.orange; // Remplacez par AppColors.draw
      case 'loss':
        return Colors.red; // Remplacez par AppColors.loss
      default:
        return Colors.grey;
    }
  }
}