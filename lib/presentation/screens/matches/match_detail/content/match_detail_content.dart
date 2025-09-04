// lib/presentation/screens/matches/content/match_detail_content.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/data/models/match.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/widgets/match_header.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/widgets/match_result.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/widgets/player_stats_section.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/widgets/team_composition.dart';

class MatchDetailContent extends StatelessWidget {
  final Match match;

  const MatchDetailContent({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          MatchHeader(match: match),
          if (match.status == MatchStatus.completed) ...[
            MatchResults(match: match),
            if (match.playerStats != null)
              PlayerStatsSection(match: match, playerProvider: playerProvider),
          ],
          if (match.selectedPlayers != null)
            TeamComposition(match: match, playerProvider: playerProvider),
        ],
      ),
    );
  }
}