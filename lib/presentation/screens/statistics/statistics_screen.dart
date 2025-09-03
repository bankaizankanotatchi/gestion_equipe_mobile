// lib/presentation/screens/statistics/statistics_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/statistics/components/TeamStats.dart';
import 'package:team_manager_app/presentation/screens/statistics/components/TopAssists.dart';
import '../../providers/match_provider.dart';
import '../../providers/player_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import 'components/TopScorers.dart';

@RoutePage()
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STATISTIQUES', style: AppTextStyles.heading4.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        )),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.surface,
            ],
            stops: [0.1, 0.3],
          ),
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Teamstats(),
              SizedBox(height: AppConstants.paddingLarge),
              Topscorers(),
              SizedBox(height: AppConstants.paddingLarge),
              Topassists(),
              SizedBox(height: AppConstants.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }
  }