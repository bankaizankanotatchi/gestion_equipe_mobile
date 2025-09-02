// lib/presentation/screens/home/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/presentation/screens/matches/matches_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list_screen.dart';
import 'package:team_manager_app/presentation/screens/players/players_list_screen.dart';
import '../../providers/auth_provider.dart';
import '../../providers/player_provider.dart';
import '../../providers/match_provider.dart';
import '../profile/profile_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
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

  final List<BottomNavigationBarItem> _navigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined),
      activeIcon: Icon(Icons.dashboard),
      label: 'Tableau de bord',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.group_outlined),
      activeIcon: Icon(Icons.group),
      label: 'Joueurs',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer_outlined),
      activeIcon: Icon(Icons.sports_soccer),
      label: 'Matchs',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.chat_bubble_outline),
      activeIcon: Icon(Icons.chat_bubble),
      label: 'Messages',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profil',
    ),
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
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurface.withOpacity(0.6),
        selectedLabelStyle: AppTextStyles.caption.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.caption,
        items: _navigationItems,
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    final authProvider = Provider.of<AuthProvider>(context);
    
    if (!authProvider.isCoach || _currentIndex == 4 || _currentIndex == 0 || _currentIndex == 3) {
      return const SizedBox.shrink();
    }

    return ScaleTransition(
      scale: _fabAnimationController,
      child: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        child: Icon(_getFabIcon()),
      ),
    );
  }

  IconData _getFabIcon() {
    switch (_currentIndex) {
      case 1:
        return Icons.person_add;
      case 2:
        return Icons.add_box;
      default:
        return Icons.add;
    }
  }

  void _onFabPressed() {
    switch (_currentIndex) {
      case 1:
        context.router.push(AddEditPlayerRoute(playerId: null));
        break;
        
      case 2:
        context.router.push(AddMatchRoute(matchId: null));
        break;
      default:
      context.router.push(AddMatchRoute(matchId: null));
        break;
    }
  }
}

// Dashboard principal
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(context),
            const SizedBox(height: AppConstants.paddingLarge),
            _buildQuickStats(context),
            const SizedBox(height: AppConstants.paddingLarge),
            _buildUpcomingMatches(context),
            const SizedBox(height: AppConstants.paddingLarge),
            _buildRecentActivity(context),
          ],
        ),
      ),
    );
  }

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/logos/logo.png', // Chemin vers votre logo
        width: 45,
        height: 45,
        fit: BoxFit.contain,
      ),
    ),
    title: Text(
      'Team Manager',
      style: AppTextStyles.heading4.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: AppColors.surface,
    elevation: 0,
    actions: [
      Consumer<NotificationProvider>(
        builder: (context, notifProvider, child) {
          final unreadCount = notifProvider.unreadCount;

          return Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 35),
                onPressed: () {
                  context.router.push(const NotificationsRoute());
                },
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '$unreadCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    ],
  );
}
  Widget _buildWelcomeCard(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 0,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                 ClipOval(
                child: Container(
                width: 60,
                height: 60,
                color: Colors.white,
                child: user?.avatar != null
                    ? Image.asset(
                        user!.avatar!,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      )
                    : Center(
                        child: Text(
                          user?.name.substring(0, 1).toUpperCase() ?? 'U',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
              ),
            ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bonjour,',
                          style: AppTextStyles.body2.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          user?.name ?? 'Utilisateur',
                          style: AppTextStyles.heading4.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          authProvider.isCoach ? 'Entraîneur' : 'Joueur',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              Text(
                'Gérez votre équipe et suivez les performances de vos joueurs.',
                style: AppTextStyles.body2.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Consumer2<PlayerProvider, MatchProvider>(
      builder: (context, playerProvider, matchProvider, child) {
        final stats = matchProvider.getTeamStatistics();
        final activePlayers = playerProvider.activePlayers;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Statistiques rapides',
                style: AppTextStyles.heading4,
              ),
              TextButton(
                onPressed: () {
                  // Navigation vers l'écran des statistiques complètes
                  context.router.push(const StatisticsRoute());
                },
                child: Text(
                  'Voir plus',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
            const SizedBox(height: AppConstants.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Joueurs actifs',
                    '${activePlayers.length}',
                    Icons.group,
                    AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: _buildStatCard(
                    'Matchs joués',
                    '${stats['matchesPlayed']}',
                    Icons.sports_soccer,
                    AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Victoires',
                    '${stats['wins']}',
                    Icons.emoji_events,
                    AppColors.excellent,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: _buildStatCard(
                    'Buts marqués',
                    '${stats['goalsFor']}',
                    Icons.sports_score,
                    AppColors.info,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: AppConstants.iconSizeMedium,
              ),
              const Spacer(),
              Text(
                value,
                style: AppTextStyles.heading3.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingMatches(BuildContext context) {
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
                    // Naviguer vers MatchesScreen directement
                    context.router.push(const MatchesRoute());
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
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activité récente',
          style: AppTextStyles.heading4,
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        _buildActivityItem(
          'Nouveau joueur ajouté',
          'Hugo Martinez a rejoint l\'équipe',
          Icons.person_add,
          AppColors.excellent,
        ),
        _buildActivityItem(
          'Match terminé',
          'Victoire 2-1 contre FC Lions',
          Icons.sports_score,
          AppColors.primary,
        ),
        _buildActivityItem(
          'Statistiques mises à jour',
          'Notes des joueurs actualisées',
          Icons.trending_up,
          AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color) {
    return Container(
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
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
            ),
            child: Icon(
              icon,
              color: color,
              size: AppConstants.iconSizeSmall,
            ),
          ),
          const SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.subtitle2,
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
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