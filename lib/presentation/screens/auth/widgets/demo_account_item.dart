// lib/presentation/screens/auth/widgets/demo_account_item.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';

class DemoAccountItem extends StatelessWidget {
  final String role;
  final String email;
  final String password;
  final IconData icon;
  final VoidCallback onTap;

  const DemoAccountItem({
    super.key,
    required this.role,
    required this.email,
    required this.password,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingSmall),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: AppConstants.iconSizeSmall,
            ),
            const SizedBox(width: AppConstants.paddingSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    email,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.touch_app,
              color: AppColors.onSurface.withOpacity(0.5),
              size: AppConstants.iconSizeSmall,
            ),
          ],
        ),
      ),
    );
  }
}