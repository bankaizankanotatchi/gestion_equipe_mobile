// lib/presentation/screens/home/widgets/dashboard/dashboard_content.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/dashboard/quick_stats_section.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/dashboard/recent_activity_section.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/dashboard/upcoming_matches_section.dart';
import '../../../../../core/constants/app_constants.dart';
import 'welcome_card.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeCard(),
          SizedBox(height: AppConstants.paddingLarge),
          QuickStatsSection(),
          SizedBox(height: AppConstants.paddingLarge),
          UpcomingMatchesSection(),
          SizedBox(height: AppConstants.paddingLarge),
          RecentActivitySection(),
        ],
      ),
    );
  }
}