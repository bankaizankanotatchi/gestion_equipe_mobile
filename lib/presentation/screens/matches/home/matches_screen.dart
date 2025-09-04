// lib/presentation/screens/matches/matches_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import 'content/matches_content.dart';
import 'widgets/matches_tab_bar.dart';

@RoutePage()
class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchesTabBar(tabController: _tabController),
      body: TabBarView(
        controller: _tabController,
        children: const [
          UpcomingMatchesTab(),
          CompletedMatchesTab(),
        ],
      ),
    );
  }
}