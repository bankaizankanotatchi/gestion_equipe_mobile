// lib/presentation/screens/messages/components/group_chat_tile.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/presentation/providers/message_provider.dart';

class GroupChatTile extends StatelessWidget {
  final MessageProvider messageProvider;

  const GroupChatTile({
    super.key,
    required this.messageProvider,
  });

  @override
  Widget build(BuildContext context) {
    final lastMessage = messageProvider.groupMessages.isNotEmpty 
        ? messageProvider.groupMessages.last 
        : null;
        
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.group,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          'Discussion d\'équipe',
          style: AppTextStyles.subtitle1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: lastMessage != null
            ? Text(
                lastMessage.content,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : Text(
                'Tous les membres de l\'équipe',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                ),
              ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (lastMessage != null)
              Text(
                _formatTime(lastMessage.timestamp),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.5),
                ),
              ),
            const SizedBox(height: 4),
            if (messageProvider.groupMessages.any((msg) => !msg.isRead))
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
        onTap: () => _openGroupChat(context),
      ),
    );
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

  void _openGroupChat(BuildContext context) {
    context.router.push(const GroupChatRoute());
  }
}