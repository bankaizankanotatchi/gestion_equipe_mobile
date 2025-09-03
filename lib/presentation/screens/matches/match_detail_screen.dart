import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import '../../../data/models/statistics.dart' hide PlayerStats;
import '../../providers/match_provider.dart';
import '../../providers/player_provider.dart';
import '../../providers/auth_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/match.dart' hide MatchResult;
import 'components_matchdetails/match_detail_app_bar.dart';
import 'components_matchdetails/match_header.dart';
import 'components_matchdetails/team_composition.dart';
import 'components_matchdetails/match_result.dart';
import 'components_matchdetails/player_stats.dart';


@RoutePage()
class MatchDetailScreen extends StatelessWidget {
  final String matchId;

  const MatchDetailScreen({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MatchDetailAppBar(matchId: matchId),
      body: Consumer2<MatchProvider, PlayerProvider>(
        builder: (context, matchProvider, playerProvider, child) {
          final match = matchProvider.getMatchById(matchId);

          if (match == null) {
            return const Center(
              child: Text('Match non trouvé'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                MatchHeader(match: match),
                if (match.status == MatchStatus.completed) ...[
                  MatchResult(match: match),
                  if (match.playerStats != null)
                    PlayerStats(match: match, playerProvider: playerProvider),
                ],
                if (match.selectedPlayers != null)
                  TeamComposition(match: match, playerProvider: playerProvider),
              ],
            ),
          );
        },
      ),
    );
  }
}