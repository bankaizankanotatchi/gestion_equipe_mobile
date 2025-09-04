// lib/presentation/screens/profile/components/stat_card.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final BuildContext context;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.context,
    required this.icon,
    this.color =  AppColors.primary, // Remplacez par AppColors.primary
  });

  @override
  Widget build(BuildContext context) {
    // Déterminer la hauteur en fonction de la taille de l'écran
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    final double cardHeight = isTablet ? 32 : 70;
    final double iconSize = isTablet ? 14 : 20;
    final double padding = isTablet ? 4 : AppConstants.paddingMedium;
    
    return Container(
      padding: EdgeInsets.all(isTablet ? 4 : 8),
      height: cardHeight,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: iconSize),
          SizedBox(width: padding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isTablet)
                  Text(
                    title,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                Text(
                  isTablet ? title : value,
                  style: isTablet 
                    ? AppTextStyles.caption.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      )
                    : AppTextStyles.heading5.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (isTablet)
                  Text(
                    value,
                    style: AppTextStyles.heading5.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}