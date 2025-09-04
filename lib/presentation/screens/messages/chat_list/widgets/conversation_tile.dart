// lib/presentation/screens/messages/components/conversation_tile.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';

class ConversationTile extends StatelessWidget {
  final Message message;
  final String currentUserId;
  final PlayerProvider playerProvider;

  const ConversationTile({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.playerProvider,
  });

  @override
  Widget build(BuildContext context) {
    final isFromCurrentUser = message.senderId == currentUserId;
    final otherPersonId = isFromCurrentUser ? message.recipientId : message.senderId;
    final otherPersonName = isFromCurrentUser ? message.recipientId : message.senderName;
    
    // Récupérer les infos du joueur pour l'avatar
    final player = otherPersonId != null ? playerProvider.getPlayerById(otherPersonId) : null;
    final avatarText = otherPersonName!.substring(0, 1).toUpperCase();

    return Dismissible(
      key: Key(message.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Supprimer la conversation'),
            content: const Text('Êtes-vous sûr de vouloir supprimer cette conversation ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text('Supprimer'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        // TODO: Implémenter la suppression de la conversation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Conversation avec $otherPersonName supprimée')),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
          leading: player?.avatar != null
              ? CircleAvatar(
                  backgroundImage: AssetImage(player!.avatar!),
                  radius: 24,
                )
              : CircleAvatar(
                  backgroundColor: _getAvatarColor(otherPersonId ?? ''),
                  radius: 24,
                  child: Text(
                    avatarText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
          title: Text(
            otherPersonName,
            style: AppTextStyles.subtitle1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            message.content,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.onSurface.withOpacity(0.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(message.timestamp),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 4),
              if (!message.isRead && !isFromCurrentUser)
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          onTap: () => _openPrivateChat(context, message, currentUserId),
        ),
      ),
    );
  }

  Color _getAvatarColor(String userId) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
      Colors.purple,
      Colors.orange,
      Colors.teal,
    ];
    final index = userId.hashCode % colors.length;
    return colors[index];
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}j';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min';
    } else {
      return 'Maintenant';
    }
  }

  void _openPrivateChat(BuildContext context, Message message, String currentUserId) {
    final otherUserId = message.senderId == currentUserId 
        ? message.recipientId 
        : message.senderId;
    
    if (otherUserId != null) {
      context.router.push(PrivateChatRoute(userId: otherUserId));
    }
  }
}