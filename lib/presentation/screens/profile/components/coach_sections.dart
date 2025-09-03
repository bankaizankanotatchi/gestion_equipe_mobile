import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';

class CoachSections extends StatelessWidget {
  final MatchProvider matchProvider;

  const CoachSections({super.key, required this.matchProvider});

  @override
  Widget build(BuildContext context) {
    final teamStats = matchProvider.getTeamStatistics();

    return Column(
      children: [
        // Statistiques de l'équipe
        _buildTeamStatsCard(teamStats, context),
        const SizedBox(height: AppConstants.paddingLarge),

        // Actions rapides pour coach
        _buildCoachQuickActions(),
      ],
    );
  }

  Widget _buildTeamStatsCard(Map<String, dynamic> teamStats, BuildContext context) {
    final matchesPlayed = teamStats['matchesPlayed'] ?? 0;
    final wins = teamStats['wins'] ?? 0;
    final draws = teamStats['draws'] ?? 0;
    final losses = teamStats['losses'] ?? 0;
    final goalsFor = teamStats['goalsFor'] ?? 0;
    final goalsAgainst = teamStats['goalsAgainst'] ?? 0;

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
              'STATISTIQUES DE L\'ÉQUIPE',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppConstants.paddingSmall,
                  mainAxisSpacing: AppConstants.paddingSmall,
                  childAspectRatio: constraints.maxWidth > 600 ? 1.5 : 2.2,
                  children: [
                    _buildStatCard('Matchs', '$matchesPlayed', context, Icons.sports_soccer),
                    _buildStatCard('Victoires', '$wins', context, Icons.emoji_events,
                        color: AppColors.win),
                    _buildStatCard('Nuls', '$draws', context, Icons.horizontal_rule,
                        color: AppColors.draw),
                    _buildStatCard('Défaites', '$losses', context, Icons.close,
                        color: AppColors.loss),
                    _buildStatCard('Buts pour', '$goalsFor', context, Icons.sports_score,
                        color: AppColors.excellent),
                    _buildStatCard('Buts contre', '$goalsAgainst', context, Icons.shield,
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

  Widget _buildCoachQuickActions() {
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
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Wrap(
              spacing: AppConstants.paddingSmall,
              runSpacing: AppConstants.paddingSmall,
              children: [
                _buildActionChip('Ajouter joueur', Icons.person_add, Colors.green),
                _buildActionChip('Créer match', Icons.event, Colors.blue),
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