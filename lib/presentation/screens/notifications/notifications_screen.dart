// lib/presentation/screens/notifications/notifications_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/presentation/screens/notifications/widgets/notifications_app_bar.dart';
import './content/notifications_content.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;


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

  void _setFilter(notif.NotificationType? filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationsAppBar(
        onFilterSelected: _setFilter, // 👈 correction : on passe bien le callback
      ),
      body: Consumer2<NotificationProvider, AuthProvider>(
        builder: (context, notificationProvider, authProvider, child) {
          return NotificationsContent(
            notificationProvider: notificationProvider,
            authProvider: authProvider,
          );
        },
      ),
    );
  }
}
