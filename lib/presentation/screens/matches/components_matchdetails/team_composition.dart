import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/match.dart';
import 'package:team_manager_app/presentation/screens/matches/components_matchdetails/player_stats_modal.dart';

import '../../../../data/models/player.dart';
import '../add_match_screen.dart';

class TeamComposition extends StatelessWidget {
  final Match match;
  final PlayerProvider playerProvider;

  const TeamComposition({
    super.key,
    required this.match,
    required this.playerProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'COMPOSITION D\'ÉQUIPE',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),

          // Terrain de football avec les joueurs
          _buildFootballPitch(match, playerProvider),

          const SizedBox(height: AppConstants.paddingLarge),

          // Formation détectée
          _buildFormationInfo(match, playerProvider),

          const SizedBox(height: AppConstants.paddingMedium),

          // Légende des positions
          _buildPositionLegend(),

          const SizedBox(height: AppConstants.paddingLarge),

          // Remplaçants
          if (match.substitutes != null && match.substitutes!.isNotEmpty)
            _buildSubstitutes(match, playerProvider),
        ],
      ),
    );
  }

  Widget _buildFootballPitch(Match match, PlayerProvider playerProvider) {
    final startingPlayers = match.startingEleven!
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();

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
                            Colors.green.shade800
                                .withOpacity(index % 2 == 0 ? 0.15 : 0.05),
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
                ..._positionPlayersRealistic(
                    startingPlayers, containerWidth, context, match),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _positionPlayersRealistic(List<Player> players,
      double containerWidth, BuildContext context, Match match) {
    final positions = <Widget>[];

    // Grouper les joueurs par position
    final goalkeepers =
        players.where((p) => p.position == Position.goalkeeper).toList();
    final defenders =
        players.where((p) => p.position == Position.defender).toList();
    final midfielders =
        players.where((p) => p.position == Position.midfielder).toList();
    final forwards =
        players.where((p) => p.position == Position.forward).toList();

    // Dimensions en pourcentage de la largeur du conteneur
    final double fieldWidth = containerWidth * 0.75;
    final double fieldHeight = fieldWidth * 1.85;
    final double centerX = containerWidth / 2;
    final double sideMargin = (containerWidth - fieldWidth) / 2;

    // Zones verticales en pourcentage de la hauteur
    final double goalKeeperY = fieldHeight * 1;
    final double defenseY = fieldHeight * 0.78;
    final double midfieldY = fieldHeight * 0.5;
    final double attackY = fieldHeight * 0.22;

    // Positionner le gardien
    if (goalkeepers.isNotEmpty) {
      positions.add(_buildRealisticPlayer(
          goalkeepers[0], Offset(centerX, goalKeeperY), context, match));
    }

    // Positionner les défenseurs
    _positionDefenders(defenders, positions, fieldWidth, sideMargin, defenseY,
        centerX, context, match);

    // Positionner les milieux
    _positionMidfielders(midfielders, positions, fieldWidth, sideMargin,
        midfieldY, centerX, context, match);

    // Positionner les attaquants
    _positionForwards(forwards, positions, fieldWidth, sideMargin, attackY,
        centerX, context, match);

    return positions;
  }

  void _positionDefenders(
      List<Player> defenders,
      List<Widget> positions,
      double fieldWidth,
      double sideMargin,
      double defenseY,
      double centerX,
      BuildContext context,
      Match match) {
    final count = defenders.length;
    if (count == 0) return;

    final spacing = fieldWidth * 0.08;

    switch (count) {
      case 1:
        positions.add(_buildRealisticPlayer(
            defenders[0], Offset(centerX, defenseY), context, match));
        break;
      case 2:
        positions.add(_buildRealisticPlayer(
            defenders[0], Offset(centerX - spacing, defenseY), context, match));
        positions.add(_buildRealisticPlayer(
            defenders[1], Offset(centerX + spacing, defenseY), context, match));
        break;
      case 3:
        positions.add(_buildRealisticPlayer(defenders[0],
            Offset(centerX - spacing * 1.8, defenseY), context, match));
        positions.add(_buildRealisticPlayer(
            defenders[1], Offset(centerX, defenseY), context, match));
        positions.add(_buildRealisticPlayer(defenders[2],
            Offset(centerX + spacing * 1.8, defenseY), context, match));
        break;
      case 4:
        positions.add(_buildRealisticPlayer(defenders[0],
            Offset(sideMargin + spacing, defenseY), context, match));
        positions.add(_buildRealisticPlayer(defenders[1],
            Offset(centerX - spacing * 1.1, defenseY), context, match));
        positions.add(_buildRealisticPlayer(defenders[2],
            Offset(centerX + spacing * 1.1, defenseY), context, match));
        positions.add(_buildRealisticPlayer(
            defenders[3],
            Offset(fieldWidth + sideMargin - spacing, defenseY),
            context,
            match));
        break;
      case 5:
        positions.add(_buildRealisticPlayer(defenders[0],
            Offset(sideMargin + spacing * 0.5, defenseY), context, match));
        positions.add(_buildRealisticPlayer(defenders[1],
            Offset(centerX - spacing * 1.2, defenseY), context, match));
        positions.add(_buildRealisticPlayer(
            defenders[2], Offset(centerX, defenseY), context, match));
        positions.add(_buildRealisticPlayer(defenders[3],
            Offset(centerX + spacing * 1.2, defenseY), context, match));
        positions.add(_buildRealisticPlayer(
            defenders[4],
            Offset(fieldWidth + sideMargin - spacing * 0.5, defenseY),
            context,
            match));
        break;
      default:
        final step = fieldWidth / (count - 1);
        for (int i = 0; i < count; i++) {
          final x = sideMargin + (i * step);
          positions.add(_buildRealisticPlayer(
              defenders[i], Offset(x, defenseY), context, match));
        }
    }
  }

  void _positionMidfielders(
      List<Player> midfielders,
      List<Widget> positions,
      double fieldWidth,
      double sideMargin,
      double midfieldY,
      double centerX,
      BuildContext context,
      Match match) {
    final count = midfielders.length;
    if (count == 0) return;

    final spacing = fieldWidth * 0.08;

    switch (count) {
      case 1:
        positions.add(_buildRealisticPlayer(
            midfielders[0], Offset(centerX, midfieldY), context, match));
        break;
      case 2:
        positions.add(_buildRealisticPlayer(midfielders[0],
            Offset(centerX - spacing, midfieldY), context, match));
        positions.add(_buildRealisticPlayer(midfielders[1],
            Offset(centerX + spacing, midfieldY), context, match));
        break;
      case 3:
        positions.add(_buildRealisticPlayer(midfielders[0],
            Offset(centerX - spacing * 1.8, midfieldY), context, match));
        positions.add(_buildRealisticPlayer(midfielders[1],
            Offset(centerX, midfieldY - spacing * 0.5), context, match));
        positions.add(_buildRealisticPlayer(midfielders[2],
            Offset(centerX + spacing * 1.8, midfieldY), context, match));
        break;
      case 4:
        positions.add(_buildRealisticPlayer(midfielders[0],
            Offset(sideMargin + spacing, midfieldY), context, match));
        positions.add(_buildRealisticPlayer(
            midfielders[1],
            Offset(centerX - spacing * 1.1, midfieldY + spacing * 0.5),
            context,
            match));
        positions.add(_buildRealisticPlayer(
            midfielders[2],
            Offset(centerX + spacing * 1.1, midfieldY + spacing * 0.5),
            context,
            match));
        positions.add(_buildRealisticPlayer(
            midfielders[3],
            Offset(fieldWidth + sideMargin - spacing, midfieldY),
            context,
            match));
        break;
      case 5:
        positions.add(_buildRealisticPlayer(midfielders[0],
            Offset(sideMargin + spacing * 0.5, midfieldY), context, match));
        positions.add(_buildRealisticPlayer(
            midfielders[1],
            Offset(centerX - spacing * 1.2, midfieldY + spacing * 0.3),
            context,
            match));
        positions.add(_buildRealisticPlayer(midfielders[2],
            Offset(centerX, midfieldY - spacing * 0.3), context, match));
        positions.add(_buildRealisticPlayer(
            midfielders[3],
            Offset(centerX + spacing * 1.2, midfieldY + spacing * 0.3),
            context,
            match));
        positions.add(_buildRealisticPlayer(
            midfielders[4],
            Offset(fieldWidth + sideMargin - spacing * 0.5, midfieldY),
            context,
            match));
        break;
      default:
        final step = fieldWidth / (count - 1);
        for (int i = 0; i < count; i++) {
          final x = sideMargin + (i * step);
          positions.add(_buildRealisticPlayer(
              midfielders[i], Offset(x, midfieldY), context, match));
        }
    }
  }

  void _positionForwards(
      List<Player> forwards,
      List<Widget> positions,
      double fieldWidth,
      double sideMargin,
      double attackY,
      double centerX,
      BuildContext context,
      Match match) {
    final count = forwards.length;
    if (count == 0) return;

    final spacing = fieldWidth * 0.08;

    switch (count) {
      case 1:
        positions.add(_buildRealisticPlayer(
            forwards[0], Offset(centerX, attackY), context, match));
        break;
      case 2:
        positions.add(_buildRealisticPlayer(forwards[0],
            Offset(centerX - spacing * 1.5, attackY), context, match));
        positions.add(_buildRealisticPlayer(forwards[1],
            Offset(centerX + spacing * 1.5, attackY), context, match));
        break;
      case 3:
        positions.add(_buildRealisticPlayer(
            forwards[0],
            Offset(centerX - spacing * 2.2, attackY + spacing * 0.3),
            context,
            match));
        positions.add(_buildRealisticPlayer(forwards[1],
            Offset(centerX, attackY - spacing * 0.4), context, match));
        positions.add(_buildRealisticPlayer(
            forwards[2],
            Offset(centerX + spacing * 2.2, attackY + spacing * 0.3),
            context,
            match));
        break;
      case 4:
        positions.add(_buildRealisticPlayer(forwards[0],
            Offset(sideMargin + spacing, attackY), context, match));
        positions.add(_buildRealisticPlayer(
            forwards[1], Offset(centerX - spacing, attackY), context, match));
        positions.add(_buildRealisticPlayer(
            forwards[2], Offset(centerX + spacing, attackY), context, match));
        positions.add(_buildRealisticPlayer(
            forwards[3],
            Offset(fieldWidth + sideMargin - spacing, attackY),
            context,
            match));
        break;
      case 5:
        positions.add(_buildRealisticPlayer(forwards[0],
            Offset(sideMargin + spacing * 0.5, attackY), context, match));
        positions.add(_buildRealisticPlayer(
            forwards[1],
            Offset(centerX - spacing * 1.5, attackY + spacing * 0.3),
            context,
            match));
        positions.add(_buildRealisticPlayer(forwards[2],
            Offset(centerX, attackY - spacing * 0.3), context, match));
        positions.add(_buildRealisticPlayer(
            forwards[3],
            Offset(centerX + spacing * 1.5, attackY + spacing * 0.3),
            context,
            match));
        positions.add(_buildRealisticPlayer(
            forwards[4],
            Offset(fieldWidth + sideMargin - spacing * 0.5, attackY),
            context,
            match));
        break;
      default:
        final step = fieldWidth / (count - 1);
        for (int i = 0; i < count; i++) {
          final x = sideMargin + (i * step);
          positions.add(_buildRealisticPlayer(
              forwards[i], Offset(x, attackY), context, match));
        }
    }
  }

  Widget _buildRealisticPlayer(
      Player player, Offset position, BuildContext context, Match match) {
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
                          color: Colors.black
                              .withOpacity(isManOfTheMatch ? 0.8 : 0.5),
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
                    fontWeight:
                        isManOfTheMatch ? FontWeight.w900 : FontWeight.bold,
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

  String _getShortName(String fullName) {
    final names = fullName.split(' ');
    if (names.length == 1) return fullName;
    return '${names[0]} ${names[1][0]}.';
  }

  Widget _buildFormationInfo(Match match, PlayerProvider playerProvider) {
    final startingPlayers = match.startingEleven!
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();

    final formation = _detectFormation(startingPlayers);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLarge,
          vertical: AppConstants.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Text(
          'FORMATION: $formation',
          style: AppTextStyles.subtitle1.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _detectFormation(List<Player> players) {
    int defenders =
        players.where((p) => p.position == Position.defender).length;
    int midfielders =
        players.where((p) => p.position == Position.midfielder).length;
    int forwards = players.where((p) => p.position == Position.forward).length;

    // Formations classiques
    if (defenders == 4 && midfielders == 4 && forwards == 2) return '4-4-2';
    if (defenders == 4 && midfielders == 3 && forwards == 3) return '4-3-3';
    if (defenders == 4 && midfielders == 2 && forwards == 4) return '4-2-4';
    if (defenders == 3 && midfielders == 5 && forwards == 2) return '3-5-2';
    if (defenders == 3 && midfielders == 4 && forwards == 3) return '3-4-3';
    if (defenders == 5 && midfielders == 3 && forwards == 2) return '5-3-2';
    if (defenders == 5 && midfielders == 4 && forwards == 1) return '5-4-1';
    if (defenders == 4 && midfielders == 1 && forwards == 5) return '4-1-5';
    if (defenders == 3 && midfielders == 3 && forwards == 4) return '3-3-4';

    return '$defenders-$midfielders-$forwards';
  }

  Widget _buildSubstitutes(Match match, PlayerProvider playerProvider) {
    final substitutes = match.substitutes!
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REMPLAÇANTS',
          style: AppTextStyles.subtitle1.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        Wrap(
          spacing: AppConstants.paddingSmall,
          runSpacing: AppConstants.paddingSmall,
          children: substitutes.map((player) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
                vertical: AppConstants.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _getPositionColor(player.position),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        player.jerseyNumber.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    player.name,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getPositionAbbreviation(player.position),
                    style: AppTextStyles.caption.copyWith(
                      color: _getPositionColor(player.position),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPositionLegend() {
    return Wrap(
      spacing: AppConstants.paddingMedium,
      runSpacing: AppConstants.paddingSmall,
      children: [
        _buildLegendItem('GB', AppColors.goalkeeper),
        _buildLegendItem('DEF', AppColors.defender),
        _buildLegendItem('MIL', AppColors.midfielder),
        _buildLegendItem('ATT', AppColors.forward),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
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
            text,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
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
}
