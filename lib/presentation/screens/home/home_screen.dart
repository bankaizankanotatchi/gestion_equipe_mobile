// lib/presentation/screens/home/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/screens/home/dashboard_screen.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/bottom_navigation_bar.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/floating_action_button.dart';
import 'package:team_manager_app/presentation/screens/matches/home/matches_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list/chat_list_screen.dart';
import 'package:team_manager_app/presentation/screens/players/players_list_screen.dart';
import 'package:team_manager_app/presentation/screens/profile/profile_screen.dart';
import '../../../core/constants/app_constants.dart';

@RoutePage()
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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: AppConstants.animationDurationMedium,
      curve: Curves.easeInOut,
    );
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: CustomFloatingActionButton(
        currentIndex: _currentIndex,
        fabAnimationController: _fabAnimationController,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}