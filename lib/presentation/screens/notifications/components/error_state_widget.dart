import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;

  const ErrorStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error.withOpacity(0.5),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Text(
            'Erreur',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            message,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}