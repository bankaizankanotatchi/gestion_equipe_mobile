// lib/presentation/screens/matches/matches_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/matches/match_detail_screen.dart';
import '../../providers/match_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/match.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Matchs', 
          style: AppTextStyles.heading5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
        backgroundColor: AppColors.primary,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'À venir'),
            Tab(text: 'Terminés'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor:  AppColors.secondaryLight,
          indicatorWeight: 3,
          labelStyle: AppTextStyles.button.copyWith(fontSize: 14),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingMatches(),
          _buildCompletedMatches(),
        ],
      ),
    );
  }

  Widget _buildUpcomingMatches() {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final upcomingMatches = matchProvider.upcomingMatches;

        if (upcomingMatches.isEmpty) {
          return _buildEmptyState('Aucun match programmé', Icons.event);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          itemCount: upcomingMatches.length,
          itemBuilder: (context, index) {
            return _buildUpcomingMatchCard(upcomingMatches[index]);
          },
        );
      },
    );
  }

  Widget _buildCompletedMatches() {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final completedMatches = matchProvider.completedMatches;

        if (completedMatches.isEmpty) {
          return _buildEmptyState('Aucun match terminé', Icons.history);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          itemCount: completedMatches.length,
          itemBuilder: (context, index) {
            return _buildCompletedMatchCard(completedMatches[index]);
          },
        );
      },
    );
  }

  Widget _buildUpcomingMatchCard(Match match) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MatchDetailScreen(matchId: match.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            children: [
              // Date et heure
              Text(
                _formatMatchDate(match.dateTime),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _formatMatchTime(match.dateTime),
                style: AppTextStyles.subtitle2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Contenu du match
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Équipe locale (notre équipe)
                  Expanded(
                    child: Column(
                      children: [
                        _buildTeamLogo(true),
                        const SizedBox(height: 8),
                        Text(
                          'Notre Équipe',
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  // VS et informations
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'VS',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match.venue,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Programmé',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Équipe adverse
                  Expanded(
                    child: Column(
                      children: [
                        _buildTeamLogo(false),
                        const SizedBox(height: 8),
                        Text(
                          match.opponent,
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedMatchCard(Match match) {
    final result = match.result!;
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: _getResultBorderColor(result.outcome),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MatchDetailScreen(matchId: match.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            children: [
              // Date du match
              Text(
                _formatMatchDate(match.dateTime),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              // Score et équipes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Équipe locale
                  Expanded(
                    child: Column(
                      children: [
                        _buildTeamLogo(true),
                        const SizedBox(height: 8),
                        Text(
                          'Notre Équipe',
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  // Score
                  Column(
                    children: [
                      Text(
                        result.isHomeTeam
                            ? '${result.homeScore} - ${result.awayScore}'
                            : '${result.awayScore} - ${result.homeScore}',
                        style: AppTextStyles.heading3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getResultColor(result.outcome),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getResultBackgroundColor(result.outcome),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getResultText(result.outcome),
                          style: AppTextStyles.caption.copyWith(
                            color: _getResultColor(result.outcome),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Équipe adverse
                  Expanded(
                    child: Column(
                      children: [
                        _buildTeamLogo(false),
                        const SizedBox(height: 8),
                        Text(
                          match.opponent,
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Informations supplémentaires
              Text(
                match.venue,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.7),
                ),
              ),
              
              if (match.manOfTheMatch != null) ...[
                const SizedBox(height: 8),
                Text(
                  '⭐ Homme du match',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

Widget _buildTeamLogo(bool isHomeTeam) {
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isHomeTeam ? Colors.transparent : Colors.grey.shade300,
      border: Border.all(
        color: isHomeTeam ? Colors.transparent : Colors.grey.shade400,
        width: 2,
      ),
      image: isHomeTeam 
        ? const DecorationImage(
            image: AssetImage('assets/logos/logo.png'), // Chemin vers votre logo
            fit: BoxFit.cover,
          )
        : null,
    ),
    child: isHomeTeam 
      ? null // Pas de texte si c'est notre équipe (on utilise l'image)
      : Center(
          child: Text(
            'A',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
  );
}
  Color _getResultColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win;
      case MatchOutcome.draw:
        return AppColors.draw;
      case MatchOutcome.loss:
        return AppColors.loss;
    }
  }

  Color _getResultBackgroundColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win.withOpacity(0.1);
      case MatchOutcome.draw:
        return AppColors.draw.withOpacity(0.1);
      case MatchOutcome.loss:
        return AppColors.loss.withOpacity(0.1);
    }
  }

  Color _getResultBorderColor(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return AppColors.win.withOpacity(0.3);
      case MatchOutcome.draw:
        return AppColors.draw.withOpacity(0.3);
      case MatchOutcome.loss:
        return AppColors.loss.withOpacity(0.3);
    }
  }

  String _getResultText(MatchOutcome outcome) {
    switch (outcome) {
      case MatchOutcome.win:
        return 'Victoire';
      case MatchOutcome.draw:
        return 'Nul';
      case MatchOutcome.loss:
        return 'Défaite';
    }
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: AppColors.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            message,
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatMatchDate(DateTime dateTime) {
    final months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }

  String _formatMatchTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}