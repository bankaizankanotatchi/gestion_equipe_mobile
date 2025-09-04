// lib/presentation/screens/notifications/components/notification_options.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/notification.dart' as notif;

class NotificationOptions extends StatelessWidget {
  final NotificationProvider notificationProvider;

  const NotificationOptions({
    super.key,
    required this.notificationProvider,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: (value) => _handleMenuAction(value, context),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'refresh',
          child: Row(
            children: [
              Icon(Icons.refresh),
              SizedBox(width: 8),
              Text('Actualiser'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'clear_all',
          child: Row(
            children: [
              Icon(Icons.clear_all),
              SizedBox(width: 8),
              Text('Supprimer tout'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 8),
              Text('Paramètres'),
            ],
          ),
        ),
      ],
    );
  }

  void _handleMenuAction(String action, BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.currentUser == null) return;

    switch (action) {
      case 'refresh':
        await notificationProvider.refreshNotifications(authProvider.currentUser!.id);
        _showSnackBar(context, 'Notifications actualisées');
        break;
      case 'clear_all':
        _confirmClearAll(context, notificationProvider, authProvider.currentUser!.id);
        break;
      case 'settings':
        // TODO: Naviguer vers les paramètres de notifications
        break;
    }
  }

  void _confirmClearAll(BuildContext context, NotificationProvider provider, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer toutes les notifications'),
        content: const Text('Cette action est irréversible. Êtes-vous sûr ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              provider.deleteAllNotifications(userId);
              _showSnackBar(context, 'Toutes les notifications supprimées');
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class NotificationOptionsSheet extends StatelessWidget {
  final notif.Notification notification;
  final NotificationProvider notificationProvider;

  const NotificationOptionsSheet({
    super.key,
    required this.notification,
    required this.notificationProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                notificationProvider.markAsRead(notification.id);
              }
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Supprimer', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.of(context).pop();
              notificationProvider.deleteNotification(notification.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification supprimée')),
              );
            },
          ),
        ],
      ),
    );
  }
}