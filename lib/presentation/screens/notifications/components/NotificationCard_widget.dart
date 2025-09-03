import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;

class NotificationCard extends StatelessWidget {
  final notif.Notification notification;
  final String userId;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context, listen: false);

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => _confirmDelete(context, notification),
      background: Container(
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
      ),
      onDismissed: (direction) {
        provider.deleteNotification(notification.id);
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
          onTap: () => _handleNotificationTap(context, notification, provider),
          onLongPress: () => _showNotificationOptions(context, notification, provider),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationIcon(notification.type),
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

  Widget _buildNotificationIcon(notif.NotificationType type) {
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
      padding: const EdgeInsets.all(AppConstants.paddingSmall),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: AppConstants.iconSizeMedium),
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

  void _handleNotificationTap(BuildContext context, notif.Notification notification, NotificationProvider provider) {
    if (!notification.isRead) {
      provider.markAsRead(notification.id);
    }

    // Navigation en fonction du type de notification et des données
    switch (notification.type) {
      case notif.NotificationType.match:
        if (notification.data != null && notification.data!['matchId'] != null) {
          context.router.push(MatchDetailRoute(matchId: notification.data!['matchId']));
        }
        break;
      case notif.NotificationType.player:
        if (notification.data != null && notification.data!['playerId'] != null) {
          context.router.push(PlayerDetailRoute(playerId: notification.data!['playerId']));
        }
        break;
      case notif.NotificationType.message:
        if (notification.data != null && notification.data!['senderId'] != null) {
          context.router.push(const GroupChatRoute());
        }
        break;
      case notif.NotificationType.team:
      case notif.NotificationType.system:
        _showNotificationDetails(context, notification);
        break;
    }
  }

  void _showNotificationOptions(BuildContext context, notif.Notification notification, NotificationProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(notification.isRead ? Icons.mark_as_unread : Icons.mark_email_read),
              title: Text(notification.isRead ? 'Marquer comme non lu' : 'Marquer comme lu'),
              onTap: () {
                if (notification.isRead) {
                  // TODO: Implémenter marquer comme non lu
                } else {
                  provider.markAsRead(notification.id);
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.error),
              title: const Text('Supprimer', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.of(context).pop();
                provider.deleteNotification(notification.id);
                _showSnackBar(context, 'Notification supprimée');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationDetails(BuildContext context, notif.Notification notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(notification.message),
              const SizedBox(height: AppConstants.paddingMedium),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: AppConstants.iconSizeSmall,
                    color: AppColors.onSurface.withOpacity(0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Reçu le ${_formatFullDate(notification.timestamp)}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  String _formatFullDate(DateTime timestamp) {
    final months = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];

    return '${timestamp.day} ${months[timestamp.month - 1]} ${timestamp.year} à ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}