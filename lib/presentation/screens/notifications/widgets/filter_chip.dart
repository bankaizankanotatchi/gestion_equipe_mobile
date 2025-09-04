// lib/presentation/screens/notifications/components/filter_chip.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/notification.dart' as notif;
import './notification_icon.dart';

class FilterChips extends StatelessWidget {
  final notif.NotificationType selectedFilter;
  final VoidCallback onClearFilter;

  const FilterChips({
    super.key,
    required this.selectedFilter,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium, vertical: AppConstants.paddingSmall),
      child: Row(
        children: [
          Chip(
            avatar: NotificationIcon(type: selectedFilter, size: 16),
            label: Text(_getFilterName(selectedFilter)),
            onDeleted: onClearFilter,
            backgroundColor: Colors.grey.shade200,
          ),
        ],
      ),
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
}