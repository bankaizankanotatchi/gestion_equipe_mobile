// lib/presentation/screens/matches/match_detail_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/content/match_detail_content.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/widgets/match_detail_app_bar.dart';
import '../../../providers/match_provider.dart';
import '../../../providers/player_provider.dart';

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

          return MatchDetailContent(match: match);
        },
      ),
    );
  }
}