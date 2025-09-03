import 'package:flutter/material.dart';

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