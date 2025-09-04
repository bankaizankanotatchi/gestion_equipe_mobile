// lib/presentation/screens/home/widgets/dashboard/match_card.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/routing/app_router.dart';

class MatchCard extends StatelessWidget {
  final dynamic match;

  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(MatchDetailRoute(matchId: match.id));
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
    );
  }
}