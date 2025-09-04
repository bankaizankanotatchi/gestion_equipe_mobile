// lib/presentation/screens/matches/utils/position_utils.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/data/models/player.dart';

class PositionUtils {
  static Color getPositionColor(Position position) {
    switch (position) {
      case Position.goalkeeper: return AppColors.goalkeeper;
      case Position.defender: return AppColors.defender;
      case Position.midfielder: return AppColors.midfielder;
      case Position.forward: return AppColors.forward;
    }
  }

  static String getPositionAbbreviation(Position position) {
    switch (position) {
      case Position.goalkeeper: return 'GB';
      case Position.defender: return 'DEF';
      case Position.midfielder: return 'MIL';
      case Position.forward: return 'ATT';
    }
  }

  static String getPositionName(Position position) {
    switch (position) {
      case Position.goalkeeper: return 'Gardien';
      case Position.defender: return 'Défenseur';
      case Position.midfielder: return 'Milieu';
      case Position.forward: return 'Attaquant';
    }
  }
}