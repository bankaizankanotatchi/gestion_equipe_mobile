import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InteractiveJersey3D extends StatefulWidget {
  final String playerName;
  final int jerseyNumber;

  const InteractiveJersey3D({
    super.key,
    required this.playerName,
    required this.jerseyNumber,
  });

  @override
  State<InteractiveJersey3D> createState() => _InteractiveJersey3DState();
}

class _InteractiveJersey3DState extends State<InteractiveJersey3D> {
  double _rotationX = 0.0;
  double _rotationY = 0.0;
  double _lastPanX = 0.0;
  double _lastPanY = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _lastPanX = details.localPosition.dx;
        _lastPanY = details.localPosition.dy;
        // Vibration légère au début du touch
        HapticFeedback.lightImpact();
      },
      onPanUpdate: (details) {
        setState(() {
          final deltaX = details.localPosition.dx - _lastPanX;
          final deltaY = details.localPosition.dy - _lastPanY;
          
          _rotationY += deltaX * 0.01;
          _rotationX -= deltaY * 0.01;
          
          // Limiter la rotation verticale
          _rotationX = _rotationX.clamp(-1.2, 1.2);
          
          _lastPanX = details.localPosition.dx;
          _lastPanY = details.localPosition.dy;
        });
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: Jersey3DPainter(
            rotationX: _rotationX,
            rotationY: _rotationY,
            playerName: widget.playerName,
            jerseyNumber: widget.jerseyNumber,
          ),
        ),
      ),
    );
  }
}

// Custom Painter pour le maillot 3D
class Jersey3DPainter extends CustomPainter {
  final double rotationX;
  final double rotationY;
  final String playerName;
  final int jerseyNumber;

  Jersey3DPainter({
    required this.rotationX,
    required this.rotationY,
    required this.playerName,
    required this.jerseyNumber,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Dessiner l'ombre du maillot
    _drawJerseyShadow(canvas, center, size);
    
    // Dessiner le maillot principal
    _drawJerseyFront(canvas, center, size);
    
    // Dessiner les détails (numéro, nom)
    _drawJerseyDetails(canvas, center, size);
    
    // Dessiner les effets de profondeur
    _drawDepthEffects(canvas, center, size);
  }

  void _drawJerseyShadow(Canvas canvas, Offset center, Size size) {
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final shadowOffset = Offset(
      center.dx + (rotationY * 20) + 10,
      center.dy + (rotationX * 10) + size.height * 0.4,
    );

    final shadowPath = Path();
    shadowPath.addOval(Rect.fromCenter(
      center: shadowOffset,
      width: size.width * 0.6,
      height: size.height * 0.15,
    ));
    
    canvas.drawPath(shadowPath, shadowPaint);
  }

  void _drawJerseyFront(Canvas canvas, Offset center, Size size) {
    // Transformation 3D simulée
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001) // Perspective
      ..rotateX(rotationX)
      ..rotateY(rotationY);
    
    // Points du maillot avec effet 3D
    final jerseyWidth = size.width * 0.5;
    final jerseyHeight = size.height * 0.7;
    
    final topLeft = _transform3D(
      Offset(center.dx - jerseyWidth / 2, center.dy - jerseyHeight / 2),
      transform, center
    );
    final topRight = _transform3D(
      Offset(center.dx + jerseyWidth / 2, center.dy - jerseyHeight / 2),
      transform, center
    );
    final bottomLeft = _transform3D(
      Offset(center.dx - jerseyWidth / 2, center.dy + jerseyHeight / 2),
      transform, center
    );
    final bottomRight = _transform3D(
      Offset(center.dx + jerseyWidth / 2, center.dy + jerseyHeight / 2),
      transform, center
    );

    // Gradient principal (bleu vers jaune)
    final mainGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF1E3A8A), // Bleu foncé
        const Color(0xFF3B82F6), // Bleu moyen
        const Color(0xFFFCD34D), // Jaune
      ],
    );

    final jerseyPaint = Paint()
      ..shader = mainGradient.createShader(Rect.fromPoints(topLeft, bottomRight));

    // Dessiner le corps principal du maillot
    final jerseyPath = Path();
    jerseyPath.moveTo(topLeft.dx, topLeft.dy);
    jerseyPath.lineTo(topRight.dx, topRight.dy);
    jerseyPath.lineTo(bottomRight.dx, bottomRight.dy);
    jerseyPath.lineTo(bottomLeft.dx, bottomLeft.dy);
    jerseyPath.close();

    canvas.drawPath(jerseyPath, jerseyPaint);

    // Dessiner les manches
    _drawSleeves(canvas, topLeft, topRight, transform, center);
    
    // Dessiner le col
    _drawCollar(canvas, topLeft, topRight, transform, center);
  }

  void _drawSleeves(Canvas canvas, Offset topLeft, Offset topRight, Matrix4 transform, Offset center) {
    // Manche gauche
    final leftSleevePoints = [
      _transform3D(Offset(topLeft.dx - 30, topLeft.dy + 20), transform, center),
      _transform3D(Offset(topLeft.dx - 40, topLeft.dy + 80), transform, center),
      _transform3D(Offset(topLeft.dx + 10, topLeft.dy + 90), transform, center),
      topLeft,
    ];

    // Manche droite
    final rightSleevePoints = [
      topRight,
      _transform3D(Offset(topRight.dx - 10, topRight.dy + 90), transform, center),
      _transform3D(Offset(topRight.dx + 40, topRight.dy + 80), transform, center),
      _transform3D(Offset(topRight.dx + 30, topRight.dy + 20), transform, center),
    ];

    final sleevePaint = Paint()
      ..color = const Color(0xFF1E3A8A)
      ..style = PaintingStyle.fill;

    // Dessiner les manches
    final leftSleevePath = Path();
    leftSleevePath.moveTo(leftSleevePoints[0].dx, leftSleevePoints[0].dy);
    for (int i = 1; i < leftSleevePoints.length; i++) {
      leftSleevePath.lineTo(leftSleevePoints[i].dx, leftSleevePoints[i].dy);
    }
    leftSleevePath.close();
    canvas.drawPath(leftSleevePath, sleevePaint);

    final rightSleevePath = Path();
    rightSleevePath.moveTo(rightSleevePoints[0].dx, rightSleevePoints[0].dy);
    for (int i = 1; i < rightSleevePoints.length; i++) {
      rightSleevePath.lineTo(rightSleevePoints[i].dx, rightSleevePoints[i].dy);
    }
    rightSleevePath.close();
    canvas.drawPath(rightSleevePath, sleevePaint);
  }

  void _drawCollar(Canvas canvas, Offset topLeft, Offset topRight, Matrix4 transform, Offset center) {
    final collarPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Points du col en V
    final collarTop = Offset((topLeft.dx + topRight.dx) / 2, topLeft.dy);
    final collarLeft = _transform3D(
      Offset(collarTop.dx - 15, collarTop.dy + 30), transform, center
    );
    final collarRight = _transform3D(
      Offset(collarTop.dx + 15, collarTop.dy + 30), transform, center
    );

    final collarPath = Path();
    collarPath.moveTo(collarTop.dx, collarTop.dy);
    collarPath.lineTo(collarLeft.dx, collarLeft.dy);
    collarPath.lineTo(collarRight.dx, collarRight.dy);
    collarPath.close();

    canvas.drawPath(collarPath, collarPaint);
  }

  void _drawJerseyDetails(Canvas canvas, Offset center, Size size) {
    // Dessiner le numéro au centre
    _drawNumber(canvas, center, size);
    
    // Dessiner le nom en bas
    _drawPlayerName(canvas, center, size);
    
    // Dessiner les lignes décoratives
    _drawDecorativeLines(canvas, center, size);
  }

  void _drawNumber(Canvas canvas, Offset center, Size size) {
    final numberStyle = TextStyle(
      color: Colors.white,
      fontSize: size.height * 0.2,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 4,
          offset: const Offset(2, 2),
        ),
      ],
    );

    final textPainter = TextPainter(
      text: TextSpan(text: jerseyNumber.toString(), style: numberStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Appliquer la transformation 3D au texte
    final numberOffset = Offset(
      center.dx - textPainter.width / 2 + (rotationY * 10),
      center.dy - textPainter.height / 2 + (rotationX * 5),
    );

    textPainter.paint(canvas, numberOffset);
  }

  void _drawPlayerName(Canvas canvas, Offset center, Size size) {
    final nameStyle = TextStyle(
      color: Colors.white,
      fontSize: size.height * 0.06,
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 2,
          offset: const Offset(1, 1),
        ),
      ],
    );

    final textPainter = TextPainter(
      text: TextSpan(text: playerName.toUpperCase(), style: nameStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final nameOffset = Offset(
      center.dx - textPainter.width / 2 + (rotationY * 8),
      center.dy + size.height * 0.15 + (rotationX * 3),
    );

    textPainter.paint(canvas, nameOffset);
  }

  void _drawDecorativeLines(Canvas canvas, Offset center, Size size) {
    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Lignes horizontales décoratives
    for (int i = 0; i < 3; i++) {
      final y = center.dy - size.height * 0.1 + (i * 15);
      final startX = center.dx - size.width * 0.15 + (rotationY * 5);
      final endX = center.dx + size.width * 0.15 + (rotationY * 5);
      
      canvas.drawLine(
        Offset(startX, y + (rotationX * 2)),
        Offset(endX, y + (rotationX * 2)),
        linePaint,
      );
    }
  }

  void _drawDepthEffects(Canvas canvas, Offset center, Size size) {
    // Effet de brillance
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final highlightOffset = Offset(
      center.dx - (rotationY * 30),
      center.dy - (rotationX * 20) - size.height * 0.1,
    );

    canvas.drawCircle(highlightOffset, size.width * 0.1, highlightPaint);

    // Ombres internes pour la profondeur
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2);

    final shadowGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.black.withOpacity(0.3),
        Colors.transparent,
        Colors.black.withOpacity(0.1),
      ],
    );

    final shadowRect = Rect.fromCenter(
      center: center,
      width: size.width * 0.5,
      height: size.height * 0.7,
    );

    final shadowShader = shadowGradient.createShader(shadowRect);
    shadowPaint.shader = shadowShader;
    
    canvas.drawRect(shadowRect, shadowPaint);
  }

  Offset _transform3D(Offset point, Matrix4 transform, Offset center) {
    // Simuler la transformation 3D
    final dx = point.dx - center.dx;
    final dy = point.dy - center.dy;
    
    final newX = center.dx + dx * cos(rotationY) + (rotationX * 10);
    final newY = center.dy + dy * cos(rotationX) - (rotationY * 5);
    
    return Offset(newX, newY);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! Jersey3DPainter ||
        oldDelegate.rotationX != rotationX ||
        oldDelegate.rotationY != rotationY;
  }
}