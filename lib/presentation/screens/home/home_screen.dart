// lib/presentation/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match_screen.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail_screen.dart';
import 'package:team_manager_app/presentation/screens/notifications/notifications_screen.dart';
import 'package:team_manager_app/presentation/screens/players/add_edit_player_screen.dart';
import '../../providers/auth_provider.dart';
import '../../providers/player_provider.dart';
import '../../providers/match_provider.dart';
import '../players/players_list_screen.dart';
import '../matches/matches_screen.dart';
import '../messages/chat_list_screen.dart';
import '../statistics/statistics_screen.dart';
import '../profile/profile_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import 'components/UpcomingMatches_widget.dart';
import 'components/bottom_widget.dart';
import 'components/dashboard_app_bar.dart';
import 'components/floatingactionbutton_widget.dart';
import 'components/quickStats_widget.dart';
import 'components/recentactivity_widget.dart';
import 'components/welcomecard_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  late AnimationController _fabAnimationController;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const PlayersListScreen(),
    const MatchesScreen(),
    const ChatListScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fabAnimationController = AnimationController(
      duration: AppConstants.animationDurationMedium,
      vsync: this,
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: const BottomWidget(),
      floatingActionButton: FloatingactionbuttonWidget(currentIndex: _currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

// Dashboard principal
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DashboardAppBar(),
      body: SingleChildScrollView(
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
      ),
    );
  }
}