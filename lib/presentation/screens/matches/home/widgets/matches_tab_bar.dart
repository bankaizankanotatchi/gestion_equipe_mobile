// lib/presentation/screens/matches/widgets/matches_tab_bar.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';

class MatchesTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const MatchesTabBar({super.key, required this.tabController});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.5);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Matchs',
        style: AppTextStyles.heading5.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.primary,
      elevation: 0,
      bottom: TabBar(
        controller: tabController,
        tabs: const [
          Tab(text: 'À venir'),
          Tab(text: 'Terminés'),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicatorColor: AppColors.secondaryLight,
        indicatorWeight: 3,
        labelStyle: AppTextStyles.button.copyWith(fontSize: 14),
      ),
    );
  }
}