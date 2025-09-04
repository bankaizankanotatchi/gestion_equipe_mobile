// lib/presentation/screens/notifications/components/notification_icon.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/notification.dart' as notif;

class NotificationIcon extends StatelessWidget {
  final notif.NotificationType type;
  final double? size;

  const NotificationIcon({
    super.key,
    required this.type,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (type) {
      case notif.NotificationType.match:
        icon = Icons.sports_soccer;
        color = AppColors.primary;
        break;
      case notif.NotificationType.player:
        icon = Icons.person;
        color = AppColors.secondary;
        break;
      case notif.NotificationType.team:
        icon = Icons.group;
        color = AppColors.info;
        break;
      case notif.NotificationType.system:
        icon = Icons.settings;
        color = AppColors.warning;
        break;
      case notif.NotificationType.message:
        icon = Icons.chat_bubble;
        color = AppColors.accent;
        break;
    }

    return Container(
      padding: EdgeInsets.all(size != null ? 4 : AppConstants.paddingSmall),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon, 
        color: color, 
        size: size ?? AppConstants.iconSizeMedium,
      ),
    );
  }
}