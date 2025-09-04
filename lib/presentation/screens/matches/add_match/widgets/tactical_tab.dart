// lib/presentation/screens/matches/widgets/tactical_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'tactical_header.dart';
import 'player_card.dart';

class TacticalTab extends StatelessWidget {
  final Map<String, bool> selectedPlayers;
  final List<String> startingEleven;
  final List<String> substitutes;
  final Function(String) onPlayerToggled;

  const TacticalTab({
    super.key,
    required this.selectedPlayers,
    required this.startingEleven,
    required this.substitutes,
    required this.onPlayerToggled,
  });

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<PlayerProvider>(context).players;
    final positions = [Position.goalkeeper, Position.defender, Position.midfielder, Position.forward];
    
    return DefaultTabController(
      length: positions.length,
      child: Column(
        children: [
          TacticalHeader(
            startingElevenCount: startingEleven.length,
            substitutesCount: substitutes.length,
          ),
          const SizedBox(height: 20),
          TabBar(
            labelColor:  AppColors.primary,
            unselectedLabelColor: Colors.grey.shade600,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 3.0, color:  AppColors.primary),
              insets: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            tabs: positions.map((position) {
              return Tab(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_getPositionIcon(position), size: 20),
                    const SizedBox(height: 4),
                    Text(
                      _getPositionName(position), 
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              children: positions.map((position) {
                final positionPlayers = players.where((p) => p.position == position).toList();
                return _buildPlayerGrid(positionPlayers);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerGrid(List<Player> players) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return PlayerCard(
              player: player,
              isInStarting: startingEleven.contains(player.id),
              isInSubs: substitutes.contains(player.id),
              onTap: () => onPlayerToggled(player.id),
            );
          },
        );
      },
    );
  }

  IconData _getPositionIcon(Position position) {
    switch (position) {
      case Position.goalkeeper: return Icons.sports_hockey;
      case Position.defender: return Icons.security;
      case Position.midfielder: return Icons.swap_horiz;
      case Position.forward: return Icons.sports_soccer;
    }
  }

  String _getPositionName(Position position) {
    switch (position) {
      case Position.goalkeeper: return 'gardiens';
      case Position.defender: return 'défenseurs';
      case Position.midfielder: return 'milieux';
      case Position.forward: return 'attaquants';
    }
  }
}