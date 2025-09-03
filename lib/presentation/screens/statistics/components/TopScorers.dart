import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/statistics/components/player_list_card_widget.dart';

import '../../../../core/constants/colors.dart';
import '../../../providers/match_provider.dart';
import '../../../providers/player_provider.dart';

class Topscorers extends StatefulWidget {
  const Topscorers({super.key});

  @override
  State<Topscorers> createState() => _TopscorersState();
}

class _TopscorersState extends State<Topscorers> {

  @override
  Widget build(BuildContext context) {
    return Consumer2<MatchProvider, PlayerProvider>(
      builder: (context, matchProvider, playerProvider, child) {
        final topScorers = matchProvider.getTopScorers();

        return PlayerListCardWidget(
          title: 'Meilleurs Buteurs',
          icon: Icons.sports_soccer,
          emptyMessage: 'Aucun buteur disponible',
          players: topScorers.take(5).toList(),
          statBuilder: (playerData) => '${playerData['goals']} buts',
          positionColor: AppColors.excellent,
        );
      },
    );
  }
}
