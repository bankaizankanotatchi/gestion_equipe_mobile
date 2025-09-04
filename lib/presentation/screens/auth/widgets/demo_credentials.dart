// lib/presentation/screens/auth/widgets/demo_credentials.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'demo_account_item.dart';

class DemoCredentials extends StatelessWidget {
  final Function(String, String) onAccountSelected;

  const DemoCredentials({super.key, required this.onAccountSelected});

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
          DemoAccountItem(
            role: 'Entraîneur',
            email: 'jean.dubois@team.com',
            password: 'coach123',
            icon: Icons.sports,
            onTap: () => onAccountSelected('jean.dubois@team.com', 'coach123'),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          DemoAccountItem(
            role: 'Joueur',
            email: 'antoine.leroy@team.com',
            password: 'player123',
            icon: Icons.person,
            onTap: () => onAccountSelected('antoine.leroy@team.com', 'player123'),
          ),
        ],
      ),
    );
  }
}