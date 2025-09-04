// lib/presentation/screens/matches/widgets/player_item.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/data/models/match.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/modals/player_stats_modal.dart';

class PlayerItem extends StatelessWidget {
  final Player player;
  final Offset position;
  final Match match;

  const PlayerItem({
    super.key,
    required this.player,
    required this.position,
    required this.match,
  });

  String _getShortName(String fullName) {
    final names = fullName.split(' ');
    if (names.length == 1) return fullName;
    return '${names[0]} ${names[1][0]}.';
  }

  String _getPositionAbbreviation(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'GB';
      case Position.defender:
        return 'DEF';
      case Position.midfielder:
        return 'MIL';
      case Position.forward:
        return 'ATT';
    }
  }

  Color _getPositionColor(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return AppColors.goalkeeper;
      case Position.defender:
        return AppColors.defender;
      case Position.midfielder:
        return AppColors.midfielder;
      case Position.forward:
        return AppColors.forward;
    }
  }

  void _showPlayerModal(BuildContext context, Player player) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PlayerStatsModal(player: player),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isManOfTheMatch = match.manOfTheMatch == player.name;
    
    return Positioned(
      left: position.dx - 20,
      top: isManOfTheMatch ? position.dy - 55 : position.dy - 25,
      child: GestureDetector(
        onTap: () => _showPlayerModal(context, player),
        child: SizedBox(
          width: 40,
          height: isManOfTheMatch ? 100 : 70,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Couronne pour l'homme du match
              if (isManOfTheMatch) ...[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      colors: [
                        Colors.amber,
                        Colors.orange,
                      ],
                      center: Alignment.topLeft,
                      stops: [0.0, 1.0],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.6),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 18,
                    weight: 900,
                  ),
                ),
                const SizedBox(height: 2),
              ],
              
              // Cercle du joueur avec numéro
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      _getPositionColor(player.position),
                      _getPositionColor(player.position).withOpacity(0.8),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isManOfTheMatch ? Colors.amber : Colors.white,
                    width: isManOfTheMatch ? 3 : 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    player.jerseyNumber.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(isManOfTheMatch ? 0.8 : 0.5),
                          blurRadius: isManOfTheMatch ? 3 : 1,
                          offset: const Offset(0, 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 3),
              
              // Nom du joueur
              Container(
                width: 40,
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  _getShortName(player.name),
                  style: TextStyle(
                    color: isManOfTheMatch ? Colors.amber : Colors.white,
                    fontSize: 7,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              const SizedBox(height: 2),
              
              // Poste du joueur
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                decoration: BoxDecoration(
                  color: _getPositionColor(player.position),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: isManOfTheMatch ? Colors.amber : Colors.white,
                    width: isManOfTheMatch ? 1 : 0.5,
                  ),
                ),
                child: Text(
                  _getPositionAbbreviation(player.position),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 6,
                    fontWeight: isManOfTheMatch ? FontWeight.w900 : FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}