
// lib/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/theme.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'routes/app_routes.dart';

class TeamManagerApp extends StatelessWidget {
  const TeamManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      
      // Navigation initiale basée sur l'état d'authentification
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          
          return authProvider.isAuthenticated 
            ? const HomeScreen()
            : const LoginScreen();
        },
      ),
      
      // Routes nommées
      routes: AppRoutes.routes,
      
      // Route par défaut pour les erreurs
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page non trouvée'),
            ),
          ),
        );
      },
    );
  }
}
