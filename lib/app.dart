
// lib/app.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'core/constants/theme.dart';

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
