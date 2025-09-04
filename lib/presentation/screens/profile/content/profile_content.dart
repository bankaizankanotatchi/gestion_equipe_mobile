// lib/presentation/screens/profile/content/profile_content.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/data/models/user.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/app_options_section.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/coach_quick_actions.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/logout_section.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/player_career_stats.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/player_hexagon_stats.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/player_match_history.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/player_physical_info.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/profile_app_bar.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/team_stats_card.dart';
import 'package:team_manager_app/presentation/screens/profile/widgets/user_info_card.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/match_provider.dart';

class ProfileContent extends StatelessWidget {
  final User? user;
  final Player? player;
  final AuthProvider authProvider;
  final PlayerProvider playerProvider;
  final MatchProvider matchProvider;

  const ProfileContent({
    super.key,
    required this.user,
    required this.player,
    required this.authProvider,
    required this.playerProvider,
    required this.matchProvider,
  });

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomScrollView(
      slivers: [
        ProfileAppBar(user: user!, player: player),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                UserInfoCard(user: user!, player: player),
                const SizedBox(height: 16.0),
                
                // Section spécifique selon le type d'utilisateur
                if (player != null)
                  _buildPlayerSections(player!, matchProvider, context)
                else if (authProvider.isCoach)
                  _buildCoachSections(matchProvider),

                const SizedBox(height: 16.0),
                const AppOptionsSection(),
                const SizedBox(height: 16.0),
                LogoutSection(authProvider: authProvider),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerSections(Player player, MatchProvider matchProvider, BuildContext context) {
    return Column(
      children: [
        PlayerHexagonStats(player: player),
        const SizedBox(height: 16.0),
        PlayerCareerStats(player: player, matchProvider: matchProvider),
        const SizedBox(height: 16.0),
        PlayerPhysicalInfo(player: player),
        const SizedBox(height: 16.0),
        PlayerMatchHistory(player: player, matchProvider: matchProvider),
      ],
    );
  }

  Widget _buildCoachSections(MatchProvider matchProvider) {
    return Column(
      children: [
        TeamStatsCards(matchProvider: matchProvider),
        const SizedBox(height: 16.0),
        const CoachQuickActions(),
      ],
    );
  }
}