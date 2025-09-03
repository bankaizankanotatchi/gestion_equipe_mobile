import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;

class NotificationsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final notif.NotificationType? selectedFilter;
  final Function(notif.NotificationType?) onFilterChanged;

  const NotificationsAppBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        'Notifications',
        style: AppTextStyles.heading5.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.primary,
      elevation: 0,
      actions: [
        Consumer<NotificationProvider>(
          builder: (context, notificationProvider, child) {
            final unreadCount = notificationProvider.unreadCount;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Badge avec le nombre de notifications non lues
                if (unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                // Bouton de filtre
                IconButton(
                  icon: Icon(
                    selectedFilter != null ? Icons.filter_alt : Icons.filter_alt_outlined,
                    color: selectedFilter != null ? AppColors.secondaryLight : Colors.white,
                  ),
                  onPressed: () => _showFilterDialog(context, notificationProvider),
                  tooltip: 'Filtrer',
                ),
                // Bouton tout marquer comme lu
                IconButton(
                  icon: const Icon(Icons.checklist, color: Colors.white),
                  onPressed: unreadCount > 0
                      ? () => _markAllAsRead(context, notificationProvider)
                      : null,
                  tooltip: 'Tout marquer comme lu',
                ),
                // Menu options
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (value) => _handleMenuAction(value, notificationProvider, context),
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
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context, NotificationProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrer par type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: const Text('Toutes les notifications'),
              selected: selectedFilter == null,
              onTap: () {
                onFilterChanged(null);
                Navigator.of(context).pop();
              },
            ),
            ...notif.NotificationType.values.map((type) => ListTile(
              leading: _buildNotificationIcon(type, size: 20),
              title: Text(_getFilterName(type)),
              selected: selectedFilter == type,
              onTap: () {
                onFilterChanged(type);
                Navigator.of(context).pop();
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(notif.NotificationType type, {double? size}) {
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
      padding: EdgeInsets.all(size != null ? 4 : 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: size ?? 20),
    );
  }

  String _getFilterName(notif.NotificationType type) {
    switch (type) {
      case notif.NotificationType.match:
        return 'Matchs';
      case notif.NotificationType.player:
        return 'Joueurs';
      case notif.NotificationType.team:
        return 'Équipe';
      case notif.NotificationType.system:
        return 'Système';
      case notif.NotificationType.message:
        return 'Messages';
    }
  }

  void _markAllAsRead(BuildContext context, NotificationProvider provider) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.currentUser != null) {
      await provider.markAllAsRead(authProvider.currentUser!.id);
      _showSnackBar(context, 'Toutes les notifications marquées comme lues');
    }
  }

  void _handleMenuAction(String action, NotificationProvider provider, BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.currentUser == null) return;

    switch (action) {
      case 'refresh':
        await provider.refreshNotifications(authProvider.currentUser!.id);
        _showSnackBar(context, 'Notifications actualisées');
        break;
      case 'clear_all':
        _confirmClearAll(provider, authProvider.currentUser!.id, context);
        break;
      case 'settings':
      // TODO: Naviguer vers les paramètres de notifications
        break;
    }
  }

  void _confirmClearAll(NotificationProvider provider, String userId, BuildContext context) {
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
            child: const Text('Supprimer', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
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