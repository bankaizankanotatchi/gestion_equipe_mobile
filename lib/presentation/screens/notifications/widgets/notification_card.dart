// lib/presentation/screens/notifications/components/notification_card.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/presentation/screens/notifications/widgets/notification_icon.dart';
import 'package:team_manager_app/presentation/screens/notifications/widgets/notification_options.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/notification.dart' as notif;

class NotificationCard extends StatelessWidget {
  final notif.Notification notification;
  final NotificationProvider notificationProvider;
  final String userId;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.notificationProvider,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => _confirmDelete(context, notification),
      background: _buildDismissibleBackground(),
      onDismissed: (direction) {
        notificationProvider.deleteNotification(notification.id);
        _showSnackBar(context, 'Notification supprimée');
      },
      child: Card(
        color: notification.isRead ? AppColors.surface : AppColors.surfaceVariant,
        elevation: notification.isRead ? AppConstants.elevationSmall : AppConstants.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          side: notification.isRead 
              ? BorderSide.none 
              : BorderSide(color: AppColors.primary.withOpacity(0.2), width: 1),
        ),
        child: InkWell(
          onTap: () => _handleNotificationTap(context, notification),
          onLongPress: () => _showNotificationOptions(context, notification),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationIcon(type: notification.type),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: AppTextStyles.subtitle1.copyWith(
                                fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
                                color: notification.isRead ? null : AppColors.primary,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(left: 8),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.paddingSmall),
                      Text(
                        notification.message,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.onSurface.withOpacity(0.7),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.paddingSmall),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: AppConstants.iconSizeSmall,
                            color: AppColors.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(notification.timestamp),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.onSurface.withOpacity(0.5),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _getTypeName(notification.type),
                            style: AppTextStyles.caption.copyWith(
                              color: _getTypeColor(notification.type),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      color: AppColors.error,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: AppConstants.paddingLarge),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete, color: Colors.white),
          SizedBox(height: 4),
          Text(
            'Supprimer',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, notif.Notification notification) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la notification'),
        content: Text('Êtes-vous sûr de vouloir supprimer "${notification.title}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Supprimer', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    ) ?? false;
  }

  void _handleNotificationTap(BuildContext context, notif.Notification notification) {
    if (!notification.isRead) {
      notificationProvider.markAsRead(notification.id);
    }
    // Navigation en fonction du type de notification
    _navigateBasedOnType(context, notification);
  }

  void _showNotificationOptions(BuildContext context, notif.Notification notification) {
    showModalBottomSheet(
      context: context,
      builder: (context) => NotificationOptionsSheet(
        notification: notification,
        notificationProvider: notificationProvider,
      ),
    );
  }

  void _navigateBasedOnType(BuildContext context, notif.Notification notification) {
    // Implémentation de la navigation basée sur le type
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 7) {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}j';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min';
    } else {
      return 'À l\'instant';
    }
  }

  String _getTypeName(notif.NotificationType type) {
    switch (type) {
      case notif.NotificationType.match:
        return 'Match';
      case notif.NotificationType.player:
        return 'Joueur';
      case notif.NotificationType.team:
        return 'Équipe';
      case notif.NotificationType.system:
        return 'Système';
      case notif.NotificationType.message:
        return 'Message';
    }
  }

  Color _getTypeColor(notif.NotificationType type) {
    switch (type) {
      case notif.NotificationType.match:
        return AppColors.primary;
      case notif.NotificationType.player:
        return AppColors.secondary;
      case notif.NotificationType.team:
        return AppColors.info;
      case notif.NotificationType.system:
        return AppColors.warning;
      case notif.NotificationType.message:
        return AppColors.accent;
    }
  }
}