import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;

class EmptyStateWidget extends StatelessWidget {
  final notif.NotificationType? selectedFilter;
  final VoidCallback onClearFilter;

  const EmptyStateWidget({
    super.key,
    required this.selectedFilter,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selectedFilter != null
                  ? Icons.filter_alt_off
                  : Icons.notifications_off_outlined,
              size: 80,
              color: AppColors.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            Text(
              selectedFilter != null
                  ? 'Aucune notification de ce type'
                  : 'Aucune notification',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              selectedFilter != null
                  ? 'Essayez un autre filtre ou revenez plus tard'
                  : 'Vous serez informé des nouvelles activités de votre équipe',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
            if (selectedFilter != null) ...[
              const SizedBox(height: AppConstants.paddingLarge),
              ElevatedButton(
                onPressed: onClearFilter,
                child: const Text('Voir toutes les notifications'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}