// lib/presentation/screens/home/widgets/dashboard/empty_state.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/data/models/notification.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';

class EmptyStated extends StatelessWidget {
  final String message;

  const EmptyStated({super.key, required this.message, NotificationType? selectedFilter, required Null Function() onClearFilter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: AppColors.onSurface.withOpacity(0.1),
        ),
      ),
      child: Center(
        child: Text(
          message,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}