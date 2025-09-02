// lib/core/constants/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales du thème : Blanc, Bleu, Jaune, Noir
  static const Color primary = Color(0xFF023059);        // Bleu principal
  static const Color primaryLight = Color(0xFF3B82F6);    // Bleu clair
  static const Color primaryDark = Color(0xFF1E40AF);     // Bleu foncé
  
  static const Color secondary = Color(0xFFFBBF24);       // Jaune principal
  static const Color secondaryLight = Color(0xFFFDE047);  // Jaune clair
  static const Color secondaryDark = Color(0xFFD97706);   // Jaune/Orange foncé
  
  static const Color background = Color(0xFFFAFAFA);      // Blanc cassé
  static const Color surface = Colors.white;             // Blanc pur
  static const Color surfaceVariant = Color(0xFFF8FAFC); // Gris très clair
  
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Color(0xFF1F2937);    // Noir/Gris foncé
  static const Color onBackground = Color(0xFF1F2937);
  static const Color onSurface = Color(0xFF1F2937);
  
  // Couleurs d'accentuation
  static const Color accent = Color(0xFF10B981);         // Vert pour succès
  static const Color error = Color(0xFFEF4444);          // Rouge pour erreurs
  static const Color warning = Color(0xFFF59E0B);        // Orange pour avertissements
  static const Color info = Color(0xFF3B82F6);           // Bleu pour informations
  
  // Couleurs pour les statistiques
  static const Color excellent = Color(0xFF10B981);      // Vert - 85+
  static const Color good = Color(0xFF3B82F6);          // Bleu - 70-84
  static const Color average = Color(0xFFF59E0B);       // Orange - 55-69
  static const Color poor = Color(0xFFEF4444);          // Rouge - <55
  
  // Couleurs pour les positions
  static const Color goalkeeper = Color(0xFF8B5CF6);     // Violet
  static const Color defender = Color(0xFF10B981);       // Vert
  static const Color midfielder = Color(0xFF3B82F6);     // Bleu
  static const Color forward = Color(0xFFEF4444);        // Rouge
  
  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF1E3A8A),
    Color(0xFF3B82F6),
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFFFBBF24),
    Color(0xFFFDE047),
  ];
  
  // Couleurs pour les résultats de match
  static const Color win = Color(0xFF10B981);
  static const Color draw = Color(0xFF6B7280);
  static const Color loss = Color(0xFFEF4444);
  
  // Opacités
  static const double opacity10 = 0.1;
  static const double opacity20 = 0.2;
  static const double opacity50 = 0.5;
  static const double opacity80 = 0.8;
}