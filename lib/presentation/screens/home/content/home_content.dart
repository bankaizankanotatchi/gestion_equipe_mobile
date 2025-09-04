// lib/presentation/screens/home/content/home_content.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/dashboard/dashboard_content.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/match_provider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(
          value: Provider.of<AuthProvider>(context),
        ),
        ChangeNotifierProvider<PlayerProvider>.value(
          value: Provider.of<PlayerProvider>(context),
        ),
        ChangeNotifierProvider<MatchProvider>.value(
          value: Provider.of<MatchProvider>(context),
        ),
      ],
      child: const DashboardContent(),
    );
  }
}