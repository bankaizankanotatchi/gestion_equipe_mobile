// lib/presentation/screens/profile/profile_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import './content/profile_content.dart';

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
          final player = user != null ? playerProvider.getPlayerById(user.id) : null;

          return ProfileContent(
            user: user,
            player: player,
            authProvider: authProvider,
            playerProvider: playerProvider,
            matchProvider: matchProvider,
          );
        },
      ),
    );
  }
}