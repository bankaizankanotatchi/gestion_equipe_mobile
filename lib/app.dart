
// lib/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'core/constants/theme.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/home_screen.dart';

class TeamManagerApp extends StatelessWidget {
    final _appRouter = AppRouter();

   TeamManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Team Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _appRouter.config(),
 );
  }
}
