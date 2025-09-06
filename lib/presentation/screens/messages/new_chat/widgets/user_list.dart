// lib/presentation/screens/messages/new_chat/widgets/user_list.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/user.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'user_tile.dart';

class UserList extends StatelessWidget {
  final List<User> users;
  final PlayerProvider playerProvider;
  final User currentUser;

  const UserList({
    super.key,
    required this.users,
    required this.playerProvider,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final player = playerProvider.getPlayerById(user.id);

        return UserTile(
          user: user,
          player: player,
          currentUser: currentUser,
        );
      },
    );
  }
}