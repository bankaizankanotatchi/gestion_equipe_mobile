import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;

class FilterChipWidget extends StatelessWidget {
  final notif.NotificationType selectedFilter;
  final VoidCallback onClearFilter;

  const FilterChipWidget({
    super.key,
    required this.selectedFilter,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      child: Row(
        children: [
          Chip(
            avatar: _buildNotificationIcon(selectedFilter, size: 16),
            label: Text(_getFilterName(selectedFilter)),
            onDeleted: onClearFilter,
            backgroundColor: AppColors.surfaceVariant,
          ),
        ],
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
      padding: EdgeInsets.all(size != null ? 2 : 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: size ?? 16),
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