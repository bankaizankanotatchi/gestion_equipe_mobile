import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

// Import des widgets séparés
import 'components/completed_matches_tab.dart';
import 'components/matches_app_bar.dart';
import 'components/upcoming_matches_tab.dart';

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
      appBar: MatchesAppBar(tabController: _tabController),
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