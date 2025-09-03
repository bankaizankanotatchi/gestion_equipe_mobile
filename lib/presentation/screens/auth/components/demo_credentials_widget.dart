import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class DemoCredentialsWidget extends StatelessWidget {
  final void Function(String email, String password) onTap;

  const DemoCredentialsWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(
        children: [
          Text(
            'Comptes de démonstration',
            style: AppTextStyles.subtitle2.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          _demoAccount('Entraîneur', 'jean.dubois@team.com', 'coach123'),
          const SizedBox(height: AppConstants.paddingSmall),
          _demoAccount('Joueur', 'antoine.leroy@team.com', 'player123'),
        ],
      ),
    );
  }

  Widget _demoAccount(String role, String email, String password) {
    return GestureDetector(
      onTap: () => onTap(email, password),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingSmall),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
        child: Row(
          children: [
            Icon(
              role == 'Entraîneur' ? Icons.sports : Icons.person,
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
                  Text(email, style: AppTextStyles.caption),
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
