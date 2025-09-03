import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;

import 'components/empty_state_widget.dart';import 'components/FilterChip_widget.dart';
import 'components/NotificationCard_widget.dart';
import 'components/error_state_widget.dart';
import 'components/loading_state_widget.dart';
import 'components/notifications_app_bar.dart';


@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  notif.NotificationType? _selectedFilter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);

      if (authProvider.currentUser != null) {
        notificationProvider.loadNotifications(authProvider.currentUser!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationsAppBar(
        selectedFilter: _selectedFilter,
        onFilterChanged: (filter) => setState(() => _selectedFilter = filter),
      ),
      body: Consumer2<NotificationProvider, AuthProvider>(
        builder: (context, notificationProvider, authProvider, child) {
          if (authProvider.currentUser == null) {
            return ErrorStateWidget(message: 'Utilisateur non connecté');
          }

          if (notificationProvider.isLoading) {
            return const LoadingStateWidget();
          }

          final notifications = _filterNotifications(notificationProvider.notifications);

          if (notifications.isEmpty) {
            return EmptyStateWidget(
              selectedFilter: _selectedFilter,
              onClearFilter: () => setState(() => _selectedFilter = null),
            );
          }

          return RefreshIndicator(
            onRefresh: () => notificationProvider.refreshNotifications(authProvider.currentUser!.id),
            child: Column(
              children: [
                // Barre de filtre si active
                if (_selectedFilter != null)
                  FilterChipWidget(
                    selectedFilter: _selectedFilter!,
                    onClearFilter: () => setState(() => _selectedFilter = null),
                  ),
                // Liste des notifications
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppConstants.paddingSmall),
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        notification: notifications[index],
                        userId: authProvider.currentUser!.id,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<notif.Notification> _filterNotifications(List<notif.Notification> notifications) {
    if (_selectedFilter == null) return notifications;
    return notifications.where((n) => n.type == _selectedFilter).toList();
  }
}