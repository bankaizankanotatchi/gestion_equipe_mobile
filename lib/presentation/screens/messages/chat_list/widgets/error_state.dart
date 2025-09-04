// lib/presentation/screens/messages/components/error_state.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';

class ErrorState extends StatelessWidget {
  final String message;

  const ErrorState({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error,
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            'Erreur de chargement',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            message,
            style:  TextStyle(color: AppColors.onSurface.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}