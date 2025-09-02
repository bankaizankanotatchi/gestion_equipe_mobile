// lib/core/constants/app_constants.dart

class AppConstants {
  // Dimensions
  static const double borderRadius = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusSmall = 8.0;
  
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;
  
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;
  
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 48.0;
  static const double avatarSizeLarge = 64.0;
  static const double avatarSizeXLarge = 96.0;
  
  // Durées d'animation
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationLong = Duration(milliseconds: 500);
  
  // Élévations
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
  
  // Tailles des cartes
  static const double cardHeight = 120.0;
  static const double playerCardHeight = 140.0;
  static const double matchCardHeight = 160.0;
  
  // Limites
  static const int maxPlayersPerTeam = 25;
  static const int maxStartingPlayers = 11;
  static const int maxSubstitutes = 7;
  static const int minRating = 1;
  static const int maxRating = 99;
  
  // Messages
  static const int maxMessageLength = 500;
  static const int messagesPerPage = 50;
  
  // Assets
  static const String defaultPlayerAvatar = 'assets/images/default_player.png';
  static const String defaultCoachAvatar = 'assets/images/default_coach.png';
  static const String teamLogo = 'assets/images/team_logo.png';
  
  // Routes
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String playersRoute = '/players';
  static const String matchesRoute = '/matches';
  static const String messagesRoute = '/messages';
  static const String statisticsRoute = '/statistics';
  static const String profileRoute = '/profile';
}
