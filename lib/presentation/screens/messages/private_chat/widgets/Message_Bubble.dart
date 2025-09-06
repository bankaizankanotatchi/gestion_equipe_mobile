// lib/presentation/screens/messages/private_chat/widgets/message_bubble.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/data/models/user.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final User? user;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.user,
  });

  String _formatTime(DateTime timestamp) {
    return DateFormat('HH:mm').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(
                user?.avatar ?? 'assets/avatars/default_avatar.jpg',
              ),
            ),
          if (!isMe) const SizedBox(width: AppConstants.paddingSmall),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.surfaceVariant,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppConstants.borderRadiusLarge),
                  topRight: const Radius.circular(AppConstants.borderRadiusLarge),
                  bottomLeft: isMe
                      ? const Radius.circular(AppConstants.borderRadiusLarge)
                      : const Radius.circular(AppConstants.borderRadiusSmall),
                  bottomRight: isMe
                      ? const Radius.circular(AppConstants.borderRadiusSmall)
                      : const Radius.circular(AppConstants.borderRadiusLarge),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: AppTextStyles.messageContent.copyWith(
                      color: isMe ? AppColors.onPrimary : AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: AppTextStyles.messageTime.copyWith(
                      color: isMe
                          ? AppColors.onPrimary.withOpacity(0.7)
                          : AppColors.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: AppConstants.paddingSmall),
          if (isMe)
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(
                user?.avatar ?? 'assets/avatars/default_avatar.jpg',
              ),
            ),
        ],
      ),
    );
  }
}