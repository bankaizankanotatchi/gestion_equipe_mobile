// lib/presentation/screens/home/widgets/dashboard/recent_activity_section.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/text_styles.dart';
import 'activity_item.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activité récente',
          style: AppTextStyles.heading4,
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        const ActivityItem(
          title: 'Nouveau joueur ajouté',
          subtitle: 'Hugo Martinez a rejoint l\'équipe',
          icon: Icons.person_add,
          color: AppColors.excellent,
        ),
        const ActivityItem(
          title: 'Match terminé',
          subtitle: 'Victoire 2-1 contre FC Lions',
          icon: Icons.sports_score,
          color: AppColors.primary,
        ),
        const ActivityItem(
          title: 'Statistiques mises à jour',
          subtitle: 'Notes des joueurs actualisées',
          icon: Icons.trending_up,
          color: AppColors.secondary,
        ),
      ],
    );
  }
}