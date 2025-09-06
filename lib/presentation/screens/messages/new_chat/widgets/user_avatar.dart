// lib/presentation/screens/messages/new_chat/widgets/user_avatar.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/data/models/user.dart';
import 'package:team_manager_app/data/models/player.dart';

class UserAvatar extends StatelessWidget {
  final User user;
  final Player? player;

  const UserAvatar({
    super.key,
    required this.user,
    required this.player,
  });

  Color _getAvatarColor(String userId) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.indigo,
    ];
    final index = userId.hashCode % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    final isCoach = user.type == UserType.coach;
    final avatarColor = _getAvatarColor(user.id);

    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: avatarColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: avatarColor.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: player?.avatar != null
              ? CircleAvatar(
            backgroundImage: AssetImage(player!.avatar!),
            radius: 24,
          )
              : Center(
            child: Text(
              user.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        if (isCoach)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(
                Icons.star,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}