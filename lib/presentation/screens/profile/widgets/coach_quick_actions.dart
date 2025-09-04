// lib/presentation/screens/profile/components/coach_quick_actions.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';

class CoachQuickActions extends StatelessWidget {
  const CoachQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ACTIONS RAPIDES',
              style: AppTextStyles.heading5.copyWith(
                color:  AppColors.primary, // Remplacez par AppColors.primary
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Wrap(
              spacing: AppConstants.paddingSmall,
              runSpacing: AppConstants.paddingSmall,
              children: [
                _buildActionChip('Ajouter joueur', Icons.person_add, Colors.green),
                _buildActionChip('Créer match', Icons.event,  AppColors.primary),
                _buildActionChip('Voir effectif', Icons.people, Colors.orange),
                _buildActionChip('Statistiques', Icons.analytics, Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(String label, IconData icon, Color color) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
    );
  }
}