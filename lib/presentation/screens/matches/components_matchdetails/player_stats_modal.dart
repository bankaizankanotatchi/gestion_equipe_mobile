import 'dart:math';
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/data/models/player.dart';

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