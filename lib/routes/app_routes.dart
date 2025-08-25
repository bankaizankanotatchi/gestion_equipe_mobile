
// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/players/players_list_screen.dart';
import '../presentation/screens/players/player_detail_screen.dart';
import '../presentation/screens/players/add_edit_player_screen.dart';
import '../presentation/screens/matches/matches_screen.dart';
import '../presentation/screens/matches/match_detail_screen.dart';
import '../presentation/screens/matches/add_match_screen.dart';
import '../presentation/screens/messages/group_chat_screen.dart';
import '../presentation/screens/messages/private_chat_screen.dart';
import '../presentation/screens/messages/chat_list_screen.dart';
import '../presentation/screens/statistics/statistics_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../core/constants/app_constants.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    AppConstants.loginRoute: (context) => const LoginScreen(),
    AppConstants.homeRoute: (context) => const HomeScreen(),
    AppConstants.playersRoute: (context) => const PlayersListScreen(),
    AppConstants.matchesRoute: (context) => const MatchesScreen(),
    AppConstants.messagesRoute: (context) => const ChatListScreen(),
    AppConstants.statisticsRoute: (context) => const StatisticsScreen(),
    AppConstants.profileRoute: (context) => const ProfileScreen(),
  };

  // Navigation avec arguments
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/player-detail':
        final playerId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => PlayerDetailScreen(playerId: playerId),
        );
        
      case '/add-edit-player':
        final playerId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => AddEditPlayerScreen(playerId: playerId),
        );
        
      case '/match-detail':
        final matchId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => MatchDetailScreen(matchId: matchId),
        );
        
     case '/add-match':
            final matchId = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (context) => AddMatchScreen(matchId: matchId),
            );
        
      case '/private-chat':
        final userId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => PrivateChatScreen(userId: userId),
        );
        
      case '/group-chat':
        return MaterialPageRoute(
          builder: (context) => const GroupChatScreen(),
        );
        
      default:
        return null;
    }
  }
}