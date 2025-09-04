import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/player_provider.dart';
import '../../providers/match_provider.dart';
import '../../../core/constants/app_constants.dart';
import 'components/app_options_section.dart';
import 'components/coach_sections.dart';
import 'components/logout_section.dart';
import 'components/player_sections.dart';
import 'components/profile_app_bar.dart';
import 'components/user_info_section.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Consumer3<AuthProvider, PlayerProvider, MatchProvider>(
        builder: (context, authProvider, playerProvider, matchProvider, child) {
          final user = authProvider.currentUser;
          final player =
          user != null ? playerProvider.getPlayerById(user.id) : null;

          return CustomScrollView(
            slivers: [
              ProfileAppBar(user: user, player: player),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    children: [
                      if (user != null) ...[
                        UserInfoSection(user: user, player: player),
                        const SizedBox(height: AppConstants.paddingLarge),

                        // Section spécifique selon le type d'utilisateur
                        if (player != null)
                          PlayerSections(
                            player: player,
                            matchProvider: matchProvider,
                            context: context,
                          )
                        else if (authProvider.isCoach)
                          CoachSections(matchProvider: matchProvider),

                        const SizedBox(height: AppConstants.paddingLarge),
                        const AppOptionsSection(),
                        const SizedBox(height: AppConstants.paddingLarge),
                        LogoutSection(authProvider: authProvider),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}