// lib/presentation/screens/matches/match_detail_screen.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match_screen.dart';
import '../../providers/match_provider.dart';
import '../../providers/player_provider.dart';
import '../../providers/auth_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/match.dart';
import '../../../data/models/player.dart';

class MatchDetailScreen extends StatelessWidget {
  final String matchId;

  const MatchDetailScreen({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du match'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (authProvider.isCoach) {
                return PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Modifier'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Supprimer'),
                    ),
                  ],
                  onSelected: (value) => _handleMenuAction(context, value),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
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
                _buildMatchHeader(match),
                if (match.status == MatchStatus.completed) ...[
                  _buildMatchResult(match),
                  if (match.playerStats != null)
                    _buildPlayerStats(match, playerProvider),
                ],
                if (match.selectedPlayers != null)
                  _buildTeamComposition(match, playerProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMatchHeader(Match match) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Text(
            match.opponent,
            style: AppTextStyles.heading2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            _formatDateTime(match.dateTime),
            style: AppTextStyles.body1.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white.withOpacity(0.9),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                match.venue,
                style: AppTextStyles.body2.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
              vertical: AppConstants.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
            ),
            child: Text(
              _getMatchStatusText(match.status),
              style: AppTextStyles.subtitle1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchResult(Match match) {
    if (match.result == null) return const SizedBox.shrink();

    final result = match.result!;
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Résultat',
            style: AppTextStyles.heading5,
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    result.isHomeTeam ? 'Notre équipe' : match.opponent,
                    style: AppTextStyles.body1,
                  ),
                  Text(
                    result.isHomeTeam ? result.homeScore.toString() : result.awayScore.toString(),
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '-',
                style: AppTextStyles.heading2,
              ),
              Column(
                children: [
                  Text(
                    result.isHomeTeam ? match.opponent : 'Notre équipe',
                    style: AppTextStyles.body1,
                  ),
                  Text(
                    result.isHomeTeam ? result.awayScore.toString() : result.homeScore.toString(),
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
                vertical: AppConstants.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: _getResultColor(result.outcome),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Text(
                _getResultText(result.outcome),
                style: AppTextStyles.subtitle2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (match.manOfTheMatch != null) ...[
            const SizedBox(height: AppConstants.paddingMedium),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Homme du match: ${match.manOfTheMatch}',
                  style: AppTextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayerStats(Match match, PlayerProvider playerProvider) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistiques des joueurs',
            style: AppTextStyles.heading5,
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          ...match.playerStats!.entries.map((entry) {
            final player = playerProvider.getPlayerById(entry.key);
            final stats = entry.value;
            
            if (player == null) return const SizedBox.shrink();
            
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      player.name,
                      style: AppTextStyles.body1,
                    ),
                  ),
                  if (stats.goals > 0) ...[
                    const Icon(Icons.sports_soccer, size: 16, color: AppColors.primary),
                    Text('${stats.goals}', style: AppTextStyles.caption),
                    const SizedBox(width: 8),
                  ],
                  if (stats.assists > 0) ...[
                    const Icon(Icons.trending_up, size: 16, color: AppColors.secondary),
                    Text('${stats.assists}', style: AppTextStyles.caption),
                    const SizedBox(width: 8),
                  ],
                  if (stats.yellowCards > 0) ...[
                    Container(
                      width: 12,
                      height: 16,
                      color: Colors.yellow,
                    ),
                    Text('${stats.yellowCards}', style: AppTextStyles.caption),
                    const SizedBox(width: 8),
                  ],
                  if (stats.redCards > 0) ...[
                    Container(
                      width: 12,
                      height: 16,
                      color: Colors.red,
                    ),
                    Text('${stats.redCards}', style: AppTextStyles.caption),
                  ],
                  Expanded(
                    child: Text(
                      '${stats.rating}',
                      style: AppTextStyles.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getRatingColor(stats.rating),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

Widget _buildTeamComposition(Match match, PlayerProvider playerProvider) {
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
      final containerHeight = containerWidth * 1.85; // Ratio d'un terrain de football
      
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
              ..._positionPlayersRealistic(startingPlayers, containerWidth, context, match),
            ],
          ),
        ),
      );
    },
  );
}
Widget _drawRealisticPitchLines() {
  return CustomPaint(
    size: const Size(double.infinity, 500),
    painter: FootballPitchPainter(),
  );
}


List<Widget> _positionPlayersRealistic(List<Player> players, double containerWidth, BuildContext context, Match match) {
  final positions = <Widget>[];
  
  // Grouper les joueurs par position
  final goalkeepers = players.where((p) => p.position == Position.goalkeeper).toList();
  final defenders = players.where((p) => p.position == Position.defender).toList();
  final midfielders = players.where((p) => p.position == Position.midfielder).toList();
  final forwards = players.where((p) => p.position == Position.forward).toList();
  
  // Dimensions en pourcentage de la largeur du conteneur
  final double fieldWidth = containerWidth * 0.75;  // 75% de la largeur
  final double fieldHeight = fieldWidth * 1.85;     // Ratio hauteur/largeur d'un terrain
  final double centerX = containerWidth / 2;        // Centre horizontal
  final double sideMargin = (containerWidth - fieldWidth) / 2; // Marge latérale
  
  // Zones verticales en pourcentage de la hauteur
  final double goalKeeperY = fieldHeight * 1;  // 100% de la hauteur
  final double defenseY = fieldHeight * 0.78;     // 78% de la hauteur
  final double midfieldY = fieldHeight * 0.5;     // 50% de la hauteur
  final double attackY = fieldHeight * 0.22;      // 22% de la hauteur
  
  // Positionner le gardien (toujours centré)
  if (goalkeepers.isNotEmpty) {
    positions.add(_buildRealisticPlayer(goalkeepers[0], Offset(centerX, goalKeeperY), context, match));
  }
  
  // Positionner les défenseurs
  _positionDefenders(defenders, positions, fieldWidth, sideMargin, defenseY, centerX, context, match);
  
  // Positionner les milieux
  _positionMidfielders(midfielders, positions, fieldWidth, sideMargin, midfieldY, centerX, context, match);
  
  // Positionner les attaquants
  _positionForwards(forwards, positions, fieldWidth, sideMargin, attackY, centerX, context, match);
  
  return positions;
}

// Fonctions de positionnement avec espacements en pourcentage
void _positionDefenders(List<Player> defenders, List<Widget> positions, 
    double fieldWidth, double sideMargin, double defenseY, double centerX, BuildContext context, Match match) {
  final count = defenders.length;
  if (count == 0) return;

  // Calculer les espacements en pourcentage de la largeur
  final spacing = fieldWidth * 0.08;
  
  switch (count) {
    case 1:
      positions.add(_buildRealisticPlayer(defenders[0], Offset(centerX, defenseY), context, match));
      break;
    case 2:
      positions.add(_buildRealisticPlayer(defenders[0], Offset(centerX - spacing, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[1], Offset(centerX + spacing, defenseY), context, match));
      break;
    case 3:
      positions.add(_buildRealisticPlayer(defenders[0], Offset(centerX - spacing * 1.8, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[1], Offset(centerX, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[2], Offset(centerX + spacing * 1.8, defenseY), context, match));
      break;
    case 4:
      positions.add(_buildRealisticPlayer(defenders[0], Offset(sideMargin + spacing, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[1], Offset(centerX - spacing * 1.1, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[2], Offset(centerX + spacing * 1.1, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[3], Offset(fieldWidth + sideMargin - spacing, defenseY), context, match));
      break;
    case 5:
      positions.add(_buildRealisticPlayer(defenders[0], Offset(sideMargin + spacing * 0.5, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[1], Offset(centerX - spacing * 1.2, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[2], Offset(centerX, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[3], Offset(centerX + spacing * 1.2, defenseY), context, match));
      positions.add(_buildRealisticPlayer(defenders[4], Offset(fieldWidth + sideMargin - spacing * 0.5, defenseY), context, match));
      break;
    default:
      // Répartition équitable
      final step = fieldWidth / (count - 1);
      for (int i = 0; i < count; i++) {
        final x = sideMargin + (i * step);
        positions.add(_buildRealisticPlayer(defenders[i], Offset(x, defenseY), context, match));
      }
  }
}

void _positionMidfielders(List<Player> midfielders, List<Widget> positions,
    double fieldWidth, double sideMargin, double midfieldY, double centerX, BuildContext context, Match match) {
  final count = midfielders.length;
  if (count == 0) return;

  final spacing = fieldWidth * 0.08;
  
  switch (count) {
    case 1:
      positions.add(_buildRealisticPlayer(midfielders[0], Offset(centerX, midfieldY), context,match));
      break;
    case 2:
      positions.add(_buildRealisticPlayer(midfielders[0], Offset(centerX - spacing, midfieldY), context, match));
      positions.add(_buildRealisticPlayer(midfielders[1], Offset(centerX + spacing, midfieldY), context, match));
      break;
    case 3:
      positions.add(_buildRealisticPlayer(midfielders[0], Offset(centerX - spacing * 1.8, midfieldY), context, match));
      positions.add(_buildRealisticPlayer(midfielders[1], Offset(centerX, midfieldY - spacing * 0.5), context, match));
      positions.add(_buildRealisticPlayer(midfielders[2], Offset(centerX + spacing * 1.8, midfieldY), context, match));
      break;
    case 4:
      positions.add(_buildRealisticPlayer(midfielders[0], Offset(sideMargin + spacing, midfieldY), context, match));
      positions.add(_buildRealisticPlayer(midfielders[1], Offset(centerX - spacing * 1.1, midfieldY + spacing * 0.5), context, match));
      positions.add(_buildRealisticPlayer(midfielders[2], Offset(centerX + spacing * 1.1, midfieldY + spacing * 0.5), context, match));
      positions.add(_buildRealisticPlayer(midfielders[3], Offset(fieldWidth + sideMargin - spacing, midfieldY), context, match));
      break;
    case 5:
      positions.add(_buildRealisticPlayer(midfielders[0], Offset(sideMargin + spacing * 0.5, midfieldY), context, match));
      positions.add(_buildRealisticPlayer(midfielders[1], Offset(centerX - spacing * 1.2, midfieldY + spacing * 0.3), context, match));
      positions.add(_buildRealisticPlayer(midfielders[2], Offset(centerX, midfieldY - spacing * 0.3), context, match));
      positions.add(_buildRealisticPlayer(midfielders[3], Offset(centerX + spacing * 1.2, midfieldY + spacing * 0.3), context, match));
      positions.add(_buildRealisticPlayer(midfielders[4], Offset(fieldWidth + sideMargin - spacing * 0.5, midfieldY), context, match));
      break;
    default:
      final step = fieldWidth / (count - 1);
      for (int i = 0; i < count; i++) {
        final x = sideMargin + (i * step);
        positions.add(_buildRealisticPlayer(midfielders[i], Offset(x, midfieldY), context, match));
      }
  }
}

void _positionForwards(List<Player> forwards, List<Widget> positions,
    double fieldWidth, double sideMargin, double attackY, double centerX, BuildContext context, Match match) {
  final count = forwards.length;
  if (count == 0) return;

  final spacing = fieldWidth * 0.08;
  
  switch (count) {
    case 1:
      positions.add(_buildRealisticPlayer(forwards[0], Offset(centerX, attackY), context, match));
      break;
    case 2:
      positions.add(_buildRealisticPlayer(forwards[0], Offset(centerX - spacing * 1.5, attackY), context, match));
      positions.add(_buildRealisticPlayer(forwards[1], Offset(centerX + spacing * 1.5, attackY), context, match));
      break;
    case 3:
      positions.add(_buildRealisticPlayer(forwards[0], Offset(centerX - spacing * 2.2, attackY + spacing * 0.3), context, match));
      positions.add(_buildRealisticPlayer(forwards[1], Offset(centerX, attackY - spacing * 0.4), context, match));
      positions.add(_buildRealisticPlayer(forwards[2], Offset(centerX + spacing * 2.2, attackY + spacing * 0.3), context, match));
      break;
    case 4:
      positions.add(_buildRealisticPlayer(forwards[0], Offset(sideMargin + spacing, attackY), context, match));
      positions.add(_buildRealisticPlayer(forwards[1], Offset(centerX - spacing, attackY), context, match));
      positions.add(_buildRealisticPlayer(forwards[2], Offset(centerX + spacing, attackY), context, match));
      positions.add(_buildRealisticPlayer(forwards[3], Offset(fieldWidth + sideMargin - spacing, attackY), context, match));
      break;
    case 5:
      positions.add(_buildRealisticPlayer(forwards[0], Offset(sideMargin + spacing * 0.5, attackY), context, match));
      positions.add(_buildRealisticPlayer(forwards[1], Offset(centerX - spacing * 1.5, attackY + spacing * 0.3), context, match));
      positions.add(_buildRealisticPlayer(forwards[2], Offset(centerX, attackY - spacing * 0.3), context, match));
      positions.add(_buildRealisticPlayer(forwards[3], Offset(centerX + spacing * 1.5, attackY + spacing * 0.3), context, match));
      positions.add(_buildRealisticPlayer(forwards[4], Offset(fieldWidth + sideMargin - spacing * 0.5, attackY), context, match));
      break;
    default:
      final step = fieldWidth / (count - 1);
      for (int i = 0; i < count; i++) {
        final x = sideMargin + (i * step);
        positions.add(_buildRealisticPlayer(forwards[i], Offset(x, attackY), context, match));
      }
  }
}

Widget _buildRealisticPlayer(Player player, Offset position, BuildContext context, Match match) {
  final bool isManOfTheMatch = match.manOfTheMatch == player.name;
  
  return Positioned(
    left: position.dx - 20,
    top: isManOfTheMatch ? position.dy - 55 : position.dy - 25,
    child: GestureDetector(
      onTap: () => _showPlayerModal(context, player),
      child: SizedBox(
        width: 40,
        height: isManOfTheMatch ? 100 : 70, // Augmenter la hauteur si c'est l'homme du match
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

String _detectFormation(List<Player> players) {
  int defenders = players.where((p) => p.position == Position.defender).length;
  int midfielders = players.where((p) => p.position == Position.midfielder).length;
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
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} à ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getMatchStatusText(MatchStatus status) {
    switch (status) {
      case MatchStatus.scheduled:
        return 'Programmé';
      case MatchStatus.inProgress:
        return 'En cours';
      case MatchStatus.completed:
        return 'Terminé';
      case MatchStatus.cancelled:
        return 'Annulé';
    }
  }

  String _getResultText(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return 'VICTOIRE';
      case MatchOutcome.draw:
        return 'MATCH NUL';
      case MatchOutcome.loss:
        return 'DÉFAITE';
    }
  }

  Color _getResultColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.accent;
      case MatchOutcome.draw:
        return AppColors.warning;
      case MatchOutcome.loss:
        return AppColors.error;
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

  Color _getRatingColor(double rating) {
    if (rating >= 8.0) return AppColors.excellent;
    if (rating >= 7.0) return AppColors.good;
    if (rating >= 6.0) return AppColors.average;
    return AppColors.poor;
  }

    void _showPlayerModal(BuildContext context, Player player) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => PlayerStatsModal(player: player),
      );
    }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMatchScreen(matchId: matchId),
          ),
        );
        break;
      case 'delete':
        _showDeleteDialog(context);
        break;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le match'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce match ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<MatchProvider>(context, listen: false).deleteMatch(matchId);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}


class FootballPitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final width = size.width;
    final height = size.height;

    // Bordures du terrain
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, width, height),
        const Radius.circular(8),
      ),
      paint,
    );

    // Ligne médiane
    canvas.drawLine(
      Offset(0, height / 2),
      Offset(width, height / 2),
      paint,
    );

    // Cercle central
    final centerX = width / 2;
    final centerY = height / 2;
    canvas.drawCircle(
      Offset(centerX, centerY),
      40,
      paint,
    );
    
    // Point central
    canvas.drawCircle(
      Offset(centerX, centerY),
      3,
      Paint()..color = Colors.white..style = PaintingStyle.fill,
    );

    // Surface de réparation supérieure (équipe adverse)
    final penaltyAreaWidth = width * 0.4;
    final penaltyAreaHeight = 80.0;
    final penaltyLeft = (width - penaltyAreaWidth) / 2;
    
    canvas.drawRect(
      Rect.fromLTWH(penaltyLeft, 0, penaltyAreaWidth, penaltyAreaHeight),
      paint,
    );

    // Surface de but supérieure
    final goalAreaWidth = width * 0.2;
    final goalAreaHeight = 30.0;
    final goalLeft = (width - goalAreaWidth) / 2;
    
    canvas.drawRect(
      Rect.fromLTWH(goalLeft, 0, goalAreaWidth, goalAreaHeight),
      paint,
    );

    // Arc de cercle surface de réparation supérieure
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, penaltyAreaHeight),
        width: 60,
        height: 60,
      ),
      -0.0472, 
      3.0944,  // 120 degrés en radians
      false,
      paint,
    );

    // Point de penalty supérieur
    canvas.drawCircle(
      Offset(centerX, 55),
      3,
      Paint()..color = Colors.white..style = PaintingStyle.fill,
    );

    // Surface de réparation inférieure (notre équipe)
    canvas.drawRect(
      Rect.fromLTWH(penaltyLeft, height - penaltyAreaHeight, penaltyAreaWidth, penaltyAreaHeight),
      paint,
    );

    // Surface de but inférieure
    canvas.drawRect(
      Rect.fromLTWH(goalLeft, height - goalAreaHeight, goalAreaWidth, goalAreaHeight),
      paint,
    );

    // Arc de cercle surface de réparation inférieure
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, height - penaltyAreaHeight),
        width: 60,
        height: 60,
      ),
      3.0944,  
      3.0944,  // 120 degrés en radians
      false,
      paint,
    );

    // Point de penalty inférieur
    canvas.drawCircle(
      Offset(centerX, height - 55),
      3,
      Paint()..color = Colors.white..style = PaintingStyle.fill,
    );

    // Coins du terrain
    final cornerRadius = 8.0;
    
    // Coin supérieur gauche
    canvas.drawArc(
      Rect.fromLTWH(0, 0, cornerRadius * 2, cornerRadius * 2),
      0, // 0 degrés
      1.5708, // 90 degrés en radians
      false,
      paint,
    );
    
    // Coin supérieur droit
    canvas.drawArc(
      Rect.fromLTWH(width - cornerRadius * 2, 0, cornerRadius * 2, cornerRadius * 2),
      1.5708, // 90 degrés
      1.5708, // 90 degrés
      false,
      paint,
    );
    
    // Coin inférieur gauche
    canvas.drawArc(
      Rect.fromLTWH(0, height - cornerRadius * 2, cornerRadius * 2, cornerRadius * 2),
      4.7124, // 270 degrés
      1.5708, // 90 degrés
      false,
      paint,
    );
    
    // Coin inférieur droit
    canvas.drawArc(
      Rect.fromLTWH(width - cornerRadius * 2, height - cornerRadius * 2, cornerRadius * 2, cornerRadius * 2),
      3.1416, // 180 degrés
      1.5708, // 90 degrés
      false,
      paint,
    );

    // Buts (représentés par des rectangles plus épais)
    final goalPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final goalWidth = width * 0.15;
    final goalLeft2 = (width - goalWidth) / 2;
    
    // But supérieur
    canvas.drawRect(
      Rect.fromLTWH(goalLeft2, -8, goalWidth, 8),
      goalPaint,
    );
    
    // But inférieur
    canvas.drawRect(
      Rect.fromLTWH(goalLeft2, height, goalWidth, 8),
      goalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class PlayerStatsModal extends StatelessWidget {
  final Player player;

  const PlayerStatsModal({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                // Header avec avatar et infos basiques
                _buildPlayerHeader(context),
                // Hexagone des statistiques
                _buildHexagonStats(),
                // Détails des statistiques
                _buildStatsDetails(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayerHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getPositionColor(player.position),
            _getPositionColor(player.position).withOpacity(0.7)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Bouton de fermeture
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          
          // Avatar et infos du joueur
          Row(
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(player.avatar!),
                  child: player.avatar == null
                      ? Text(
                          player.jerseyNumber.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Infos du joueur
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _getPositionName(player.position),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Text(
                        'Note: ${player.overallRating.round()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHexagonStats() {
    final stats = player.stats;
    final statValues = [
      stats.pace.toDouble(),
      stats.shooting.toDouble(),
      stats.passing.toDouble(),
      stats.dribbling.toDouble(),
      stats.defending.toDouble(),
      stats.physical.toDouble(),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'STATISTIQUES',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Hexagone des statistiques
          SizedBox(
            width: 200,
            height: 200,
            child: CustomPaint(
              painter: HexagonStatsPainter(statValues),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsDetails() {
    final stats = player.stats;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Ligne 1 des statistiques
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('Vitesse', stats.pace, AppColors.excellent),
              _buildStatItem('Tir', stats.shooting, AppColors.error),
              _buildStatItem('Passes', stats.passing, AppColors.info),
            ],
          ),
          const SizedBox(height: 16),
          // Ligne 2 des statistiques
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('Dribble', stats.dribbling, AppColors.secondary),
              _buildStatItem('Défense', stats.defending, AppColors.good),
              _buildStatItem('Physique', stats.physical, AppColors.warning),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value, Color color) {
    return Column(
      children: [
        // Barre de progression
        Stack(
          children: [
            Container(
              width: 80,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              width: 80 * (value / 100),
              height: 8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Valeur
        Text(
          '$value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        // Label
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
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

  String _getPositionName(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'Gardien de but';
      case Position.defender:
        return 'Défenseur';
      case Position.midfielder:
        return 'Milieu de terrain';
      case Position.forward:
        return 'Attaquant';
    }
  }
}

// Custom painter pour l'hexagone des statistiques
class HexagonStatsPainter extends CustomPainter {
  final List<double> stats;

  HexagonStatsPainter(this.stats);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.8;
    final points = <Offset>[];
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Dessiner l'hexagone de fond
    final backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 6; i++) {
      final angle = 2 * pi * i / 6 - pi / 2;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      points.add(Offset(x, y));
    }

    final backgroundPath = Path();
    backgroundPath.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      backgroundPath.lineTo(points[i].dx, points[i].dy);
    }
    backgroundPath.close();
    canvas.drawPath(backgroundPath, backgroundPaint);

    // Dessiner les lignes de grille
    final gridPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int level = 1; level <= 5; level++) {
      final levelRadius = radius * level / 5;
      final levelPoints = <Offset>[];
      
      for (int i = 0; i < 6; i++) {
        final angle = 2 * pi * i / 6 - pi / 2;
        final x = center.dx + levelRadius * cos(angle);
        final y = center.dy + levelRadius * sin(angle);
        levelPoints.add(Offset(x, y));
      }

      final levelPath = Path();
      levelPath.moveTo(levelPoints[0].dx, levelPoints[0].dy);
      for (int i = 1; i < levelPoints.length; i++) {
        levelPath.lineTo(levelPoints[i].dx, levelPoints[i].dy);
      }
      levelPath.close();
      canvas.drawPath(levelPath, gridPaint);
    }

    // Dessiner les lignes radiales
    for (final point in points) {
      canvas.drawLine(center, point, gridPaint);
    }

    // Dessiner le polygone des statistiques
    final statsPoints = <Offset>[];
    for (int i = 0; i < 6; i++) {
      final statValue = stats[i].clamp(0, 100);
      final statRadius = radius * statValue / 100;
      final angle = 2 * pi * i / 6 - pi / 2;
      final x = center.dx + statRadius * cos(angle);
      final y = center.dy + statRadius * sin(angle);
      statsPoints.add(Offset(x, y));
    }

    final statsPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final statsBorderPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final statsPath = Path();
    statsPath.moveTo(statsPoints[0].dx, statsPoints[0].dy);
    for (int i = 1; i < statsPoints.length; i++) {
      statsPath.lineTo(statsPoints[i].dx, statsPoints[i].dy);
    }
    statsPath.close();

    canvas.drawPath(statsPath, statsPaint);
    canvas.drawPath(statsPath, statsBorderPaint);

    // Ajouter les labels des statistiques
    final labels = ['VIT', 'TIR', 'PAS', 'DRI', 'DEF', 'PHY'];
    final labelStyle = TextStyle(
      color: AppColors.onSurface,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );

    for (int i = 0; i < 6; i++) {
      final angle = 2 * pi * i / 6 - pi / 2;
      final labelRadius = radius * 1.1;
      final x = center.dx + labelRadius * cos(angle);
      final y = center.dy + labelRadius * sin(angle);
      
      textPainter.text = TextSpan(text: labels[i], style: labelStyle);
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}