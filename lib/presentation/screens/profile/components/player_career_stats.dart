import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';

class PlayerCareerStats extends StatelessWidget {
  final Map<String, dynamic> playerStats;
  final Map<String, dynamic> matchStats;
  final BuildContext context;

  const PlayerCareerStats({
    super.key,
    required this.playerStats,
    required this.matchStats,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STATISTIQUES DE CARRIÈRE',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                final childAspectRatio = constraints.maxWidth > 600 ? 1.5 : 2.2;

                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppConstants.paddingSmall,
                  mainAxisSpacing: AppConstants.paddingSmall,
                  childAspectRatio: childAspectRatio,
                  children: [
                    _buildStatCard('Matchs joués', '${matchStats['matchesPlayed']}', context,
                        Icons.sports_soccer),
                    _buildStatCard(
                        'Buts', '${playerStats['goals']}', context, Icons.sports_score),
                    _buildStatCard('Passes D', '${playerStats['assists']}', context,
                        Icons.assistant),
                    _buildStatCard(
                        'Titularisations', '${matchStats['starting']}', context, Icons.star),
                    _buildStatCard('Cartons J',
                        '${playerStats['yellowCards']}', context, Icons.warning,
                        color: AppColors.warning),
                    _buildStatCard(
                        'Cartons R', '${playerStats['redCards']}', context, Icons.block,
                        color: AppColors.error),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, BuildContext context, IconData icon,
      {Color color = AppColors.primary}) {
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