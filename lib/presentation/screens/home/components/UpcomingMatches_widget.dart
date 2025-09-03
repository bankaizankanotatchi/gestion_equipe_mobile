import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../providers/match_provider.dart';
import '../../matches/match_detail_screen.dart';
import '../../matches/matches_screen.dart';

class UpcomingMatchesSection extends StatelessWidget {
  const UpcomingMatchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final upcomingMatches = matchProvider.upcomingMatches.take(3).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prochains matchs',
                  style: AppTextStyles.heading4,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MatchesScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Voir tout',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            if (upcomingMatches.isEmpty)
              _buildEmptyState('Aucun match programmé')
            else
              ...upcomingMatches.map((match) => _buildMatchCard(match, context)),
          ],
        );
      },
    );
  }

  Widget _buildMatchCard(match, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MatchDetailScreen(matchId: match.id),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.paddingSmall),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                ),
                child: const Icon(
                  Icons.sports_soccer,
                  color: AppColors.primary,
                  size: AppConstants.iconSizeMedium,
                ),
              ),
              const SizedBox(width: AppConstants.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'vs ${match.opponent}',
                      style: AppTextStyles.subtitle1,
                    ),
                    Text(
                      '${match.dateTime.day}/${match.dateTime.month}/${match.dateTime.year} à ${match.dateTime.hour}:${match.dateTime.minute.toString().padLeft(2, '0')}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.onSurface.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      match.venue,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.onSurface.withOpacity(0.3),
                size: AppConstants.iconSizeSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: AppColors.onSurface.withOpacity(0.1),
        ),
      ),
      child: Center(
        child: Text(
          message,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}