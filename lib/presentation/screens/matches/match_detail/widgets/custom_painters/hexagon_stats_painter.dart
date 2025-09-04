// lib/presentation/screens/matches/widgets/custom_painters/hexagon_stats_painter.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';

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