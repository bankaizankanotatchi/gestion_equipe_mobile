// lib/presentation/screens/notifications/content/notifications_content.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/screens/notifications/widgets/empty_state.dart';
import 'package:team_manager_app/presentation/screens/notifications/widgets/error_state.dart';
import 'package:team_manager_app/presentation/screens/notifications/widgets/loading_state.dart';
import 'package:team_manager_app/presentation/screens/notifications/widgets/notification_card.dart';
import '../../../providers/notification_provider.dart';
import '../../../providers/auth_provider.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;
import 'package:team_manager_app/presentation/screens/notifications/widgets/filter_chip.dart';

class NotificationsContent extends StatefulWidget {
  final NotificationProvider notificationProvider;
  final AuthProvider authProvider;

  const NotificationsContent({
    super.key,
    required this.notificationProvider,
    required this.authProvider,
  });

  @override
  State<NotificationsContent> createState() => NotificationsContentState();
}

class NotificationsContentState extends State<NotificationsContent> {
  notif.NotificationType? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    if (widget.authProvider.currentUser == null) {
      return ErrorState(message: 'Utilisateur non connecté');
    }

    if (widget.notificationProvider.isLoading) {
      return const LoadingState();
    }

    final notifications = _filterNotifications(widget.notificationProvider.notifications);
    
    if (notifications.isEmpty) {
      return EmptyStates(
        selectedFilter: _selectedFilter,
        onClearFilter: () {
          setState(() {
            _selectedFilter = null;
          });
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () => widget.notificationProvider.refreshNotifications(widget.authProvider.currentUser!.id),
      child: Column(
        children: [
          // Barre de filtre si active
          if (_selectedFilter != null)
            FilterChips(
              selectedFilter: _selectedFilter!,
              onClearFilter: () {
                setState(() {
                  _selectedFilter = null;
                });
              },
            ),
          // Liste des notifications
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              itemBuilder: (context, index) {
                return NotificationCard(
                  notification: notifications[index],
                  notificationProvider: widget.notificationProvider,
                  userId: widget.authProvider.currentUser!.id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<notif.Notification> _filterNotifications(List<notif.Notification> notifications) {
    if (_selectedFilter == null) return notifications;
    return notifications.where((n) => n.type == _selectedFilter).toList();
  }

  // Méthodes pour gérer les filtres et autres états
  void setFilter(notif.NotificationType? filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  notif.NotificationType? get selectedFilter => _selectedFilter;
}