// lib/presentation/screens/matches/widgets/match_tab_bar.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';

class MatchTabBar extends StatelessWidget {
  final TabController tabController;

  const MatchTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade700,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        splashBorderRadius: BorderRadius.circular(10),
        tabs: const [
          Tab(
            icon: Icon(Icons.info_outline, size: 18),
            text: 'INFO',
          ),
          Tab(
            icon: Icon(Icons.emoji_events, size: 18),
            text: 'TYPE',
          ),
          Tab(
            icon: Icon(Icons.sports_soccer, size: 18),
            text: 'TACTIQUE',
          ),
          Tab(
            icon: Icon(Icons.visibility, size: 18),
            text: 'RÉSUMÉ',
          ),
        ],
      ),
    );
  }
}