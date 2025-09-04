import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/screens/auth/login_screen.dart';
import 'package:team_manager_app/presentation/screens/home/home_screen.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/add_match_screen.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail/match_detail_screen.dart';
import 'package:team_manager_app/presentation/screens/matches/home/matches_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list/chat_list_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/group_chat/group_chat_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/new_chat/new_chat_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/private_chat/private_chat_screen.dart';
import 'package:team_manager_app/presentation/screens/notifications/notifications_screen.dart';
import 'package:team_manager_app/presentation/screens/players/add_edit_player_screen.dart';
import 'package:team_manager_app/presentation/screens/players/player_detail_screen.dart';
import 'package:team_manager_app/presentation/screens/players/players_list_screen.dart';
import 'package:team_manager_app/presentation/screens/profile/profile_screen.dart';
import 'package:team_manager_app/presentation/screens/statistics/statistics_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> routes = [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: AddMatchRoute.page),
    AutoRoute(page: MatchDetailRoute.page),
    AutoRoute(page: MatchesRoute.page),
    AutoRoute(page: PrivateChatRoute.page),
    AutoRoute(page: ChatListRoute.page),
    AutoRoute(page: GroupChatRoute.page),
    AutoRoute(page: NewChatRoute.page),
    AutoRoute(page: NotificationsRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: StatisticsRoute.page),
    AutoRoute(page: AddEditPlayerRoute.page),
    AutoRoute(page: PlayerDetailRoute.page),
    AutoRoute(page: PlayersListRoute.page),
  ];
}
