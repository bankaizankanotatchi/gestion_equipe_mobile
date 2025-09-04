// lib/presentation/screens/players/player_detail_screen.dart
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import '../../providers/player_provider.dart';
import '../../providers/auth_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/player.dart';
import '../../../data/database/mock_database.dart';
import '../../../data/models/match.dart';

@RoutePage()
class PlayerDetailScreen extends StatelessWidget {
  final String playerId;

  const PlayerDetailScreen({
    super.key,
    required this.playerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PlayerProvider>(
        builder: (context, playerProvider, child) {
          final player = playerProvider.getPlayerById(playerId);

          if (player == null) {
            return const Center(
              child: Text('Joueur non trouvé'),
            );
          }

          // Récupérer les statistiques complètes du joueur
          final playerStats = _getPlayerCompleteStats(player.id);
          final matchStats = _getPlayerMatchStats(player.id);

          return CustomScrollView(
            slivers: [
              _buildPlayerHeader(player, context),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildPlayerHexagonStats(player),
                    _buildPlayerCareerStats(playerStats, matchStats),
                    _buildPlayerPhysicalInfo(player),
                    _buildPlayerMatchHistory(player.id),
                    const SizedBox(height: AppConstants.paddingLarge),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayerHeader(Player player, BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.75,
      stretch: true,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = constraints.biggest.height;
          final isTitleVisible = top < MediaQuery.of(context).size.height * 0.3;

          return FlexibleSpaceBar(
            centerTitle: false,
            title: isTitleVisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        player.name,
                        style: AppTextStyles.heading5.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          if (authProvider.isCoach) {
                            return PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: InkWell(
                                    onTap: () {
                                      context.router.push(AddEditPlayerRoute(playerId: playerId));
                                    },
                                    child: const Text('Modifier'),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Supprimer'),
                                ),
                              ],
                              onSelected: (value) =>
                                  _handleMenuAction(context, value),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            stretchModes: const [StretchMode.zoomBackground],
            background: Stack(
              children: [
                // Image de fond de l'avatar
                if (player.avatar != null)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      player.avatar!,
                      fit: BoxFit.cover,
                    ),
                  ),

                // Dégradé sombre en bas pour la lisibilité du texte
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(1.0),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Contenu positionné en absolu en bas
                Positioned(
                  bottom: AppConstants.paddingLarge,
                  left: AppConstants.paddingLarge,
                  right: AppConstants.paddingLarge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nom du joueur
                      Text(
                        player.name,
                        style: AppTextStyles.heading3.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.6),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppConstants.paddingSmall),

                      // Position et numéro de maillot
                      Row(
                        children: [
                          Text(
                            _getPositionName(player.position),
                            style: AppTextStyles.body1.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppConstants.paddingMedium),
                          Text(
                            "Dorsal ${player.jerseyNumber.toString()}",
                            style: AppTextStyles.body1.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppConstants.paddingMedium),

                      // Note globale
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingMedium,
                          vertical: AppConstants.paddingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                              AppConstants.borderRadiusLarge),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Note globale: ${player.overallRating.round()}',
                              style: AppTextStyles.subtitle1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayerHexagonStats(Player player) {
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
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.all(AppConstants.paddingSmall),
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
        children: [
          Text(
            'CARACTÉRISTIQUES',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          // Hexagone des statistiques
          SizedBox(
            width: 200,
            height: 200,
            child: CustomPaint(
              painter: HexagonStatsPainter(statValues),
            ),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          // Légende des statistiques
          Wrap(
            spacing: AppConstants.paddingMedium,
            runSpacing: AppConstants.paddingSmall,
            children: [
              _buildStatLegend('Vitesse', stats.pace, AppColors.excellent),
              _buildStatLegend('Tir', stats.shooting, AppColors.error),
              _buildStatLegend('Passes', stats.passing, AppColors.info),
              _buildStatLegend('Dribble', stats.dribbling, AppColors.secondary),
              _buildStatLegend('Défense', stats.defending, AppColors.good),
              _buildStatLegend('Physique', stats.physical, AppColors.warning),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatLegend(String label, int value, Color color) {
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
          const SizedBox(width: AppConstants.paddingSmall),
          Text(
            '$label: $value',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCareerStats(
      Map<String, dynamic> playerStats, Map<String, dynamic> matchStats) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingSmall),
      padding: const EdgeInsets.all(AppConstants.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STATISTIQUES DE CARRIÈRE',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppConstants.paddingSmall,
            mainAxisSpacing: AppConstants.paddingSmall,
            childAspectRatio: 2.5,
            children: [
              _buildStatCard('Matchs joués', '${matchStats['matchesPlayed']}',
                  Icons.sports_soccer),
              _buildStatCard(
                  'Buts', '${playerStats['goals']}', Icons.sports_score),
              _buildStatCard('Passes D', '${playerStats['assists']}',
                  Icons.assistant),
              _buildStatCard(
                  'Titularisations', '${matchStats['starting']}', Icons.star),
              _buildStatCard('Cartons jaunes', '${playerStats['yellowCards']}',
                  Icons.warning,
                  color: AppColors.warning),
              _buildStatCard(
                  'Cartons rouges', '${playerStats['redCards']}', Icons.block,
                  color: AppColors.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon,
      {Color color = AppColors.primary}) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingSmall),
      height: 70,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: AppConstants.paddingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.onSurface.withOpacity(0.7),
                  ),
                ),
                Text(
                  value,
                  style: AppTextStyles.heading5.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerPhysicalInfo(Player player) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INFORMATIONS PHYSIQUES',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          _buildInfoRow('Âge', '${player.age} ans'),
          _buildInfoRow('Taille', '180 cm'),
          _buildInfoRow('Poids', '75 kg'),
          _buildInfoRow('Pied fort', 'Droit'),
        ],
      ),
    );
  }

  Widget _buildPlayerMatchHistory(String playerId) {
    final matches = _getPlayerMatches(playerId);

    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HISTORIQUE DES MATCHS',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          ...matches.take(5).map((match) => _buildMatchRow(match, playerId)),
        ],
      ),
    );
  }

  Widget _buildMatchRow(Match match, String playerId) {
    final playerStats = match.playerStats?[playerId];
    final isStarter = match.startingEleven.contains(playerId);

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'vs ${match.opponent}',
                  style: AppTextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatDate(match.dateTime),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingSmall,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: isStarter ? AppColors.primary : AppColors.secondary,
              borderRadius:
                  BorderRadius.circular(AppConstants.borderRadiusSmall),
            ),
            child: Text(
              isStarter ? 'Titulaire' : 'Remplaçant',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
          if (playerStats != null) ...[
            const SizedBox(width: AppConstants.paddingSmall),
            _buildStatIndicator('⚽', playerStats.goals),
            _buildStatIndicator('🎯', playerStats.assists),
            _buildStatIndicator('⭐', playerStats.rating.round()),
          ],
        ],
      ),
    );
  }

  Widget _buildStatIndicator(String emoji, int value) {
    if (value == 0) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$emoji$value',
        style: AppTextStyles.caption.copyWith(fontSize: 10),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.onSurface.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyles.body1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Méthodes pour récupérer les statistiques
  Map<String, dynamic> _getPlayerCompleteStats(String playerId) {
    final matches = MockDatabase.instance.getCompletedMatches();
    int goals = 0;
    int assists = 0;
    int yellowCards = 0;
    int redCards = 0;

    for (final match in matches) {
      if (match.playerStats != null &&
          match.playerStats!.containsKey(playerId)) {
        final stats = match.playerStats![playerId]!;
        goals += stats.goals;
        assists += stats.assists;
        yellowCards += stats.yellowCards;
        redCards += stats.redCards;
      }
    }

    return {
      'goals': goals,
      'assists': assists,
      'yellowCards': yellowCards,
      'redCards': redCards,
    };
  }

  Map<String, dynamic> _getPlayerMatchStats(String playerId) {
    final matches = MockDatabase.instance.getCompletedMatches();
    int matchesPlayed = 0;
    int starting = 0;

    for (final match in matches) {
      if (match.selectedPlayers.contains(playerId)) {
        matchesPlayed++;
        if (match.startingEleven.contains(playerId)) {
          starting++;
        }
      }
    }

    return {
      'matchesPlayed': matchesPlayed,
      'starting': starting,
      'substitute': matchesPlayed - starting,
    };
  }

  List<Match> _getPlayerMatches(String playerId) {
    return MockDatabase.instance
        .getCompletedMatches()
        .where((match) => match.selectedPlayers.contains(playerId))
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        Navigator.pushNamed(context, '/add-edit-player', arguments: playerId);
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
        title: const Text('Supprimer le joueur'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce joueur ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<PlayerProvider>(context, listen: false)
                  .deletePlayer(playerId);
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
