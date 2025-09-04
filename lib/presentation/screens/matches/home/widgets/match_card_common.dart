// lib/presentation/screens/matches/widgets/match_card_common.dart
import 'dart:ui';

import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/data/models/match.dart';

class MatchCardCommon {
  static String formatMatchDate(DateTime dateTime) {
    final months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }

  static String formatMatchTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static Color getResultColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win;
      case MatchOutcome.draw:
        return AppColors.draw;
      case MatchOutcome.loss:
        return AppColors.loss;
    }
  }

  static Color getResultBackgroundColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win.withOpacity(0.1);
      case MatchOutcome.draw:
        return AppColors.draw.withOpacity(0.1);
      case MatchOutcome.loss:
        return AppColors.loss.withOpacity(0.1);
    }
  }

  static Color getResultBorderColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win.withOpacity(0.3);
      case MatchOutcome.draw:
        return AppColors.draw.withOpacity(0.3);
      case MatchOutcome.loss:
        return AppColors.loss.withOpacity(0.3);
    }
  }

  static String getResultText(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return 'Victoire';
      case MatchOutcome.draw:
        return 'Nul';
      case MatchOutcome.loss:
        return 'Défaite';
    }
  }
}