// lib/presentation/screens/home/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/dashboard/dashboard_app_bar.dart';
import 'package:team_manager_app/presentation/screens/home/widgets/dashboard/dashboard_content.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(),
      body: const DashboardContent(),
    );
  }
}