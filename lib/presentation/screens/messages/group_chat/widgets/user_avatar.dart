// lib/presentation/screens/messages/group_chat/components/user_avatar.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';

class UserAvatar extends StatelessWidget {
  final String userId;
  final PlayerProvider playerProvider;
  final bool isCoach;
  final double size;

  const UserAvatar({
    super.key,
    required this.userId,
    required this.playerProvider,
    required this.isCoach,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    final player = playerProvider.getPlayerById(userId);
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isCoach ? Colors.amber : AppColors.primary,
          width: isCoach ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: isCoach ? Colors.amber.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
        backgroundImage: player?.avatar != null ? AssetImage(player!.avatar!) : null,
        child: player?.avatar == null
            ? Text(
                isCoach ? 'C' : 'J',
                style: TextStyle(
                  color: isCoach ? Colors.amber : AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.375,
                ),
              )
            : null,
      ),
    );
  }
}