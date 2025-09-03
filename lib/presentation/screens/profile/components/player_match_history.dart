import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/match.dart';

class PlayerMatchHistory extends StatelessWidget {
  final String playerId;
  final MatchProvider matchProvider;

  const PlayerMatchHistory({
    super.key,
    required this.playerId,
    required this.matchProvider,
  });

  @override
  Widget build(BuildContext context) {
    final matches = _getPlayerMatches(playerId, matchProvider);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DERNIERS MATCHS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            ...matches.take(3).map((match) => _buildMatchRow(match, playerId)),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchRow(Match match, String playerId) {
    final playerStats = match.playerStats?[playerId];
    final isStarter = match.startingEleven != null &&
        match.startingEleven!.contains(playerId);
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
              color: isStarter ? Colors.blue : Colors.orange,
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
      case MatchOutcome.win:
        return Colors.green;
      case MatchOutcome.draw:
        return Colors.orange;
      case MatchOutcome.loss:
        return Colors.red;
    }
  }

  List<Match> _getPlayerMatches(String playerId, MatchProvider matchProvider) {
    return matchProvider.completedMatches
        .where((match) =>
    match.selectedPlayers != null &&
        match.selectedPlayers!.contains(playerId))
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }
}