// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddEditPlayerRoute.name: (routeData) {
      final args = routeData.argsAs<AddEditPlayerRouteArgs>(
          orElse: () => const AddEditPlayerRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddEditPlayerScreen(
          key: args.key,
          playerId: args.playerId,
        ),
      );
    },
    AddMatchRoute.name: (routeData) {
      final args = routeData.argsAs<AddMatchRouteArgs>(
          orElse: () => const AddMatchRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddMatchScreen(
          key: args.key,
          matchId: args.matchId,
        ),
      );
    },
    ChatListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatListScreen(),
      );
    },
    GroupChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GroupChatScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MatchDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MatchDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MatchDetailScreen(
          key: args.key,
          matchId: args.matchId,
        ),
      );
    },
    MatchesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MatchesScreen(),
      );
    },
    NewChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewChatScreen(),
      );
    },
    NotificationsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationsScreen(),
      );
    },
    PlayerDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PlayerDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PlayerDetailScreen(
          key: args.key,
          playerId: args.playerId,
        ),
      );
    },
    PlayersListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlayersListScreen(),
      );
    },
    PrivateChatRoute.name: (routeData) {
      final args = routeData.argsAs<PrivateChatRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PrivateChatScreen(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    StatisticsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StatisticsScreen(),
      );
    },
  };
}

/// generated route for
/// [AddEditPlayerScreen]
class AddEditPlayerRoute extends PageRouteInfo<AddEditPlayerRouteArgs> {
  AddEditPlayerRoute({
    Key? key,
    String? playerId,
    List<PageRouteInfo>? children,
  }) : super(
          AddEditPlayerRoute.name,
          args: AddEditPlayerRouteArgs(
            key: key,
            playerId: playerId,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEditPlayerRoute';

  static const PageInfo<AddEditPlayerRouteArgs> page =
      PageInfo<AddEditPlayerRouteArgs>(name);
}

class AddEditPlayerRouteArgs {
  const AddEditPlayerRouteArgs({
    this.key,
    this.playerId,
  });

  final Key? key;

  final String? playerId;

  @override
  String toString() {
    return 'AddEditPlayerRouteArgs{key: $key, playerId: $playerId}';
  }
}

/// generated route for
/// [AddMatchScreen]
class AddMatchRoute extends PageRouteInfo<AddMatchRouteArgs> {
  AddMatchRoute({
    Key? key,
    String? matchId,
    List<PageRouteInfo>? children,
  }) : super(
          AddMatchRoute.name,
          args: AddMatchRouteArgs(
            key: key,
            matchId: matchId,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMatchRoute';

  static const PageInfo<AddMatchRouteArgs> page =
      PageInfo<AddMatchRouteArgs>(name);
}

class AddMatchRouteArgs {
  const AddMatchRouteArgs({
    this.key,
    this.matchId,
  });

  final Key? key;

  final String? matchId;

  @override
  String toString() {
    return 'AddMatchRouteArgs{key: $key, matchId: $matchId}';
  }
}

/// generated route for
/// [ChatListScreen]
class ChatListRoute extends PageRouteInfo<void> {
  const ChatListRoute({List<PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GroupChatScreen]
class GroupChatRoute extends PageRouteInfo<void> {
  const GroupChatRoute({List<PageRouteInfo>? children})
      : super(
          GroupChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MatchDetailScreen]
class MatchDetailRoute extends PageRouteInfo<MatchDetailRouteArgs> {
  MatchDetailRoute({
    Key? key,
    required String matchId,
    List<PageRouteInfo>? children,
  }) : super(
          MatchDetailRoute.name,
          args: MatchDetailRouteArgs(
            key: key,
            matchId: matchId,
          ),
          initialChildren: children,
        );

  static const String name = 'MatchDetailRoute';

  static const PageInfo<MatchDetailRouteArgs> page =
      PageInfo<MatchDetailRouteArgs>(name);
}

class MatchDetailRouteArgs {
  const MatchDetailRouteArgs({
    this.key,
    required this.matchId,
  });

  final Key? key;

  final String matchId;

  @override
  String toString() {
    return 'MatchDetailRouteArgs{key: $key, matchId: $matchId}';
  }
}

/// generated route for
/// [MatchesScreen]
class MatchesRoute extends PageRouteInfo<void> {
  const MatchesRoute({List<PageRouteInfo>? children})
      : super(
          MatchesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MatchesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewChatScreen]
class NewChatRoute extends PageRouteInfo<void> {
  const NewChatRoute({List<PageRouteInfo>? children})
      : super(
          NewChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationsScreen]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlayerDetailScreen]
class PlayerDetailRoute extends PageRouteInfo<PlayerDetailRouteArgs> {
  PlayerDetailRoute({
    Key? key,
    required String playerId,
    List<PageRouteInfo>? children,
  }) : super(
          PlayerDetailRoute.name,
          args: PlayerDetailRouteArgs(
            key: key,
            playerId: playerId,
          ),
          initialChildren: children,
        );

  static const String name = 'PlayerDetailRoute';

  static const PageInfo<PlayerDetailRouteArgs> page =
      PageInfo<PlayerDetailRouteArgs>(name);
}

class PlayerDetailRouteArgs {
  const PlayerDetailRouteArgs({
    this.key,
    required this.playerId,
  });

  final Key? key;

  final String playerId;

  @override
  String toString() {
    return 'PlayerDetailRouteArgs{key: $key, playerId: $playerId}';
  }
}

/// generated route for
/// [PlayersListScreen]
class PlayersListRoute extends PageRouteInfo<void> {
  const PlayersListRoute({List<PageRouteInfo>? children})
      : super(
          PlayersListRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlayersListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrivateChatScreen]
class PrivateChatRoute extends PageRouteInfo<PrivateChatRouteArgs> {
  PrivateChatRoute({
    Key? key,
    required String userId,
    List<PageRouteInfo>? children,
  }) : super(
          PrivateChatRoute.name,
          args: PrivateChatRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'PrivateChatRoute';

  static const PageInfo<PrivateChatRouteArgs> page =
      PageInfo<PrivateChatRouteArgs>(name);
}

class PrivateChatRouteArgs {
  const PrivateChatRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final String userId;

  @override
  String toString() {
    return 'PrivateChatRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StatisticsScreen]
class StatisticsRoute extends PageRouteInfo<void> {
  const StatisticsRoute({List<PageRouteInfo>? children})
      : super(
          StatisticsRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatisticsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
