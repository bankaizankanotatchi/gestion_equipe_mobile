// lib/presentation/screens/messages/new_chat/widgets/user_tile.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/data/models/user.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'user_avatar.dart';

class UserTile extends StatelessWidget {
  final User user;
  final Player? player;
  final User currentUser;

  const UserTile({
    super.key,
    required this.user,
    required this.player,
    required this.currentUser,
  });

  String _getPositionName(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'Gardien';
      case Position.defender:
        return 'Défenseur';
      case Position.midfielder:
        return 'Milieu';
      case Position.forward:
        return 'Attaquant';
    }
  }

  void _startChatWithUser(BuildContext context, User user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Nouvelle discussion avec ${user.name}"),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCoach = user.type == UserType.coach;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: UserAvatar(user: user, player: player),
        title: Text(
          user.name,
          style: AppTextStyles.subtitle1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isCoach ? 'Entraîneur' : 'Joueur',
              style: AppTextStyles.caption.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            if (player != null && !isCoach)
              Text(
                '${_getPositionName(player!.position)} • N°${player?.jerseyNumber}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary.withOpacity(0.7),
                ),
              ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.chat,
            size: 18,
            color: AppColors.primary,
          ),
        ),
        onTap: () => _startChatWithUser(context, user),
      ),
    );
  }
}