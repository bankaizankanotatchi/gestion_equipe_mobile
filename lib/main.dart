// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'app.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/player_provider.dart';
import 'presentation/providers/match_provider.dart';
import 'presentation/providers/message_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
        ChangeNotifierProvider(create: (_) => MatchProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: TeamManagerApp(),
    ),
  );
}