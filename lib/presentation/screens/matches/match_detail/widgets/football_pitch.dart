// lib/presentation/screens/matches/widgets/football_pitch.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/match.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/widgets/custom_painters/football_pitch_painter.dart';
import 'player_item.dart';

class FootballPitch extends StatelessWidget {
  final Match match;
  final PlayerProvider playerProvider;

  const FootballPitch({
    super.key,
    required this.match,
    required this.playerProvider,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = constraints.maxWidth;
        final containerHeight = containerWidth * 1.85;
        
        return Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            child: Stack(
              children: [
                // Fond de pelouse
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2D5016),
                        Color(0xFF4A7C59),
                        Color(0xFF5D8B3A),
                        Color(0xFF4A7C59),
                        Color(0xFF2D5016),
                      ],
                      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                
                // Rayures de pelouse
                ...List.generate(25, (index) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    top: (index * (containerHeight / 25)).toDouble(),
                    child: Container(
                      height: containerHeight / 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade800.withOpacity(index % 2 == 0 ? 0.15 : 0.05),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  );
                }),
                
                // Lignes du terrain
                CustomPaint(
                  size: Size(containerWidth, containerHeight),
                  painter: FootballPitchPainter(),
                ),
                
                // Placement des joueurs
                ..._positionPlayers(match, playerProvider, containerWidth, containerHeight, context),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _positionPlayers(Match match, PlayerProvider playerProvider, 
      double containerWidth, double containerHeight, BuildContext context) {
    final startingPlayers = match.startingEleven!
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();

    final positions = <Widget>[];
    
    // Grouper les joueurs par position
    final goalkeepers = startingPlayers.where((p) => p.position == Position.goalkeeper).toList();
    final defenders = startingPlayers.where((p) => p.position == Position.defender).toList();
    final midfielders = startingPlayers.where((p) => p.position == Position.midfielder).toList();
    final forwards = startingPlayers.where((p) => p.position == Position.forward).toList();
    
    // Dimensions en pourcentage
    final double fieldWidth = containerWidth * 0.75;
    final double fieldHeight = containerHeight;
    final double centerX = containerWidth / 2;
    final double sideMargin = (containerWidth - fieldWidth) / 2;
    
    // Zones verticales
    final double goalKeeperY = fieldHeight * 0.92;
    final double defenseY = fieldHeight * 0.78;
    final double midfieldY = fieldHeight * 0.5;
    final double attackY = fieldHeight * 0.22;
    
    // Positionner le gardien
    if (goalkeepers.isNotEmpty) {
      positions.add(PlayerItem(
        player: goalkeepers[0],
        position: Offset(centerX, goalKeeperY),
        match: match,
      ));
    }
    
    // Positionner les défenseurs
    _positionLine(defenders, positions, fieldWidth, sideMargin, defenseY, centerX, match);
    
    // Positionner les milieux
    _positionLine(midfielders, positions, fieldWidth, sideMargin, midfieldY, centerX, match);
    
    // Positionner les attaquants
    _positionLine(forwards, positions, fieldWidth, sideMargin, attackY, centerX, match);
    
    return positions;
  }

  void _positionLine(List<Player> players, List<Widget> positions, 
      double fieldWidth, double sideMargin, double lineY, double centerX, Match match) {
    final count = players.length;
    if (count == 0) return;

    final spacing = fieldWidth * 0.08;
    
    switch (count) {
      case 1:
        positions.add(PlayerItem(player: players[0], position: Offset(centerX, lineY), match: match));
        break;
      case 2:
        positions.add(PlayerItem(player: players[0], position: Offset(centerX - spacing, lineY), match: match));
        positions.add(PlayerItem(player: players[1], position: Offset(centerX + spacing, lineY), match: match));
        break;
      case 3:
        positions.add(PlayerItem(player: players[0], position: Offset(centerX - spacing * 1.8, lineY), match: match));
        positions.add(PlayerItem(player: players[1], position: Offset(centerX, lineY), match: match));
        positions.add(PlayerItem(player: players[2], position: Offset(centerX + spacing * 1.8, lineY), match: match));
        break;
      case 4:
        positions.add(PlayerItem(player: players[0], position: Offset(sideMargin + spacing, lineY), match: match));
        positions.add(PlayerItem(player: players[1], position: Offset(centerX - spacing * 1.1, lineY), match: match));
        positions.add(PlayerItem(player: players[2], position: Offset(centerX + spacing * 1.1, lineY), match: match));
        positions.add(PlayerItem(player: players[3], position: Offset(fieldWidth + sideMargin - spacing, lineY), match: match));
        break;
      case 5:
        positions.add(PlayerItem(player: players[0], position: Offset(sideMargin + spacing * 0.5, lineY), match: match));
        positions.add(PlayerItem(player: players[1], position: Offset(centerX - spacing * 1.2, lineY), match: match));
        positions.add(PlayerItem(player: players[2], position: Offset(centerX, lineY), match: match));
        positions.add(PlayerItem(player: players[3], position: Offset(centerX + spacing * 1.2, lineY), match: match));
        positions.add(PlayerItem(player: players[4], position: Offset(fieldWidth + sideMargin - spacing * 0.5, lineY), match: match));
        break;
      default:
        final step = fieldWidth / (count - 1);
        for (int i = 0; i < count; i++) {
          final x = sideMargin + (i * step);
          positions.add(PlayerItem(player: players[i], position: Offset(x, lineY), match: match));
        }
    }
  }
}