import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/statistics/components/player_list_card_widget.dart';

import '../../../../core/constants/colors.dart';
import '../../../providers/match_provider.dart';
import '../../../providers/player_provider.dart';

class Topassists extends StatefulWidget {
  const Topassists({super.key});

  @override
  State<Topassists> createState() => _TopassistsState();
}

class _TopassistsState extends State<Topassists> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MatchProvider, PlayerProvider>(
      builder: (context, matchProvider, playerProvider, child) {
        final topAssists = matchProvider.getTopAssists();

        return PlayerListCardWidget(
          title: 'MEILLEURS PASSEURS',
          icon: Icons.assistant,
          emptyMessage: 'Aucune passe décisive pour le moment',
          players: topAssists.take(5).toList(),
          statBuilder: (assister) => '${assister['assists']} passes',
          positionColor: AppColors.midfielder,
        );
      },
    );
  }
}
