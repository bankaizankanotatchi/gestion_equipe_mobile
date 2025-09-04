import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/colors.dart';
import './notification_options.dart';

class NotificationsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(notif.NotificationType?) onFilterSelected;

  const NotificationsAppBar({
    super.key,
    required this.onFilterSelected,
  });

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
                  icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
                  onPressed: () => _showFilterDialog(context),
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
                NotificationOptions(notificationProvider: notificationProvider),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context) {
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
              onTap: () {
                onFilterSelected(null); // 👈 callback utilisé
                Navigator.of(context).pop();
              },
            ),
            // 👉 Ici tu peux rajouter d’autres filtres selon notif.NotificationType
          ],
        ),
      ),
    );
  }

  void _markAllAsRead(BuildContext context, NotificationProvider provider) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.currentUser != null) {
      await provider.markAllAsRead(authProvider.currentUser!.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Toutes les notifications marquées comme lues')),
      );
    }
  }

  /// 👇 Correction obligatoire pour AppBar custom
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
