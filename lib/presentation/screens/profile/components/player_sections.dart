import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'hexagon_stats_painter.dart';
import 'player_career_stats.dart';
import 'player_physical_info.dart';
import 'player_match_history.dart';

class PlayerSections extends StatelessWidget {
  final Player player;
  final MatchProvider matchProvider;
  final BuildContext context;

  const PlayerSections({
    super.key,
    required this.player,
    required this.matchProvider,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final playerStats = _getPlayerCompleteStats(player.id, matchProvider);
    final matchStats = _getPlayerMatchStats(player.id, matchProvider);

    return Column(
      children: [
        // Hexagone des statistiques
        _buildPlayerHexagonStats(player),
        const SizedBox(height: AppConstants.paddingLarge),

        // Statistiques de carrière
        PlayerCareerStats(
          playerStats: playerStats,
          matchStats: matchStats,
          context: context,
        ),
        const SizedBox(height: AppConstants.paddingLarge),

        // Informations physiques
        PlayerPhysicalInfo(player: player),
        const SizedBox(height: AppConstants.paddingLarge),

        // Historique des matchs récents
        PlayerMatchHistory(
          playerId: player.id,
          matchProvider: matchProvider,
        ),
      ],
    );
  }

  Widget _buildPlayerHexagonStats(Player player) {
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
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
                _buildStatLegend('Passes', stats.passing, Colors.blue),
                _buildStatLegend('Dribble', stats.dribbling, Colors.orange),
                _buildStatLegend('Défense', stats.defending, Colors.purple),
                _buildStatLegend('Physique', stats.physical, Colors.amber),
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
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getPlayerCompleteStats(
      String playerId, MatchProvider matchProvider) {
    final matches = matchProvider.completedMatches;
    int goals = 0;
    int assists = 0;
    int yellowCards = 0;
    int redCards = 0;

    for (final match in matches) {
      if (match.playerStats != null &&
          match.playerStats!.containsKey(playerId)) {
        final stats = match.playerStats![playerId]!;
        goals += stats.goals;
        assists += stats.assists;
        yellowCards += stats.yellowCards;
        redCards += stats.redCards;
      }
    }

    return {
      'goals': goals,
      'assists': assists,
      'yellowCards': yellowCards,
      'redCards': redCards,
    };
  }

  Map<String, dynamic> _getPlayerMatchStats(
      String playerId, MatchProvider matchProvider) {
    final matches = matchProvider.completedMatches;
    int matchesPlayed = 0;
    int starting = 0;

    for (final match in matches) {
      if (match.selectedPlayers != null &&
          match.selectedPlayers!.contains(playerId)) {
        matchesPlayed++;
        if (match.startingEleven != null &&
            match.startingEleven!.contains(playerId)) {
          starting++;
        }
      }
    }

    return {
      'matchesPlayed': matchesPlayed,
      'starting': starting,
      'substitute': matchesPlayed - starting,
    };
  }
}