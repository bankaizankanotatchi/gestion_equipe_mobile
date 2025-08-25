// lib/presentation/screens/statistics/statistics_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/match_provider.dart';
import '../../providers/player_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTeamStats(),
              const SizedBox(height: AppConstants.paddingLarge),
              _buildTopScorers(),
              const SizedBox(height: AppConstants.paddingLarge),
              _buildTopAssists(),
              const SizedBox(height: AppConstants.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamStats() {
    return Consumer<MatchProvider>(
      builder: (context, matchProvider, child) {
        final stats = matchProvider.getTeamStatistics();
        
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'STATISTIQUES ÉQUIPE',
                        style: AppTextStyles.subtitle2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                
                // Première ligne de stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItemFIFA(
                      '${stats['matchesPlayed']}',
                      'MATCHS',
                      Icons.sports_soccer,
                      Colors.blue,
                    ),
                    _buildStatItemFIFA(
                      '${stats['points']}',
                      'POINTS',
                      Icons.star,
                      Colors.amber,
                    ),
                    _buildStatItemFIFA(
                      '${stats['goalsFor']}',
                      'BUTS POUR',
                      Icons.sports_score,
                      AppColors.excellent,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                
                // Deuxième ligne de stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItemFIFA(
                      '${stats['wins']}',
                      'VICTOIRES',
                      Icons.emoji_events,
                      AppColors.win,
                    ),
                    _buildStatItemFIFA(
                      '${stats['draws']}',
                      'MATCHS NULS',
                      Icons.horizontal_rule,
                      AppColors.draw,
                    ),
                    _buildStatItemFIFA(
                      '${stats['losses']}',
                      'DÉFAITES',
                      Icons.close,
                      AppColors.loss,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                
                // Barre de progression buts pour/contre
                _buildGoalsProgressBar(stats['goalsFor'], stats['goalsAgainst']),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItemFIFA(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.heading3.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildGoalsProgressBar(int goalsFor, int goalsAgainst) {
    final totalGoals = goalsFor + goalsAgainst;
    final forPercentage = totalGoals > 0 ? goalsFor / totalGoals : 0.5;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BILAN BUTS',
          style: AppTextStyles.subtitle2.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              widthFactor: forPercentage,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.excellent, AppColors.good],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$goalsFor',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '$goalsAgainst',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Buts pour', style: AppTextStyles.caption),
            Text('Buts contre', style: AppTextStyles.caption),
          ],
        ),
      ],
    );
  }

  Widget _buildTopScorers() {
    return Consumer2<MatchProvider, PlayerProvider>(
      builder: (context, matchProvider, playerProvider, child) {
        final topScorers = matchProvider.getTopScorers();
        
        return _buildPlayerListCard(
          title: 'MEILLEURS BUTEURS',
          icon: Icons.emoji_events,
          emptyMessage: 'Aucun buteur pour le moment',
          players: topScorers.take(5).toList(),
          statBuilder: (scorer) => '${scorer['goals']} buts',
          positionColor: AppColors.forward,
        );
      },
    );
  }

  Widget _buildTopAssists() {
    return Consumer2<MatchProvider, PlayerProvider>(
      builder: (context, matchProvider, playerProvider, child) {
        final topAssists = matchProvider.getTopAssists();
        
        return _buildPlayerListCard(
          title: 'MEILLEURS PASSEURS',
          icon: Icons.assistant,
          emptyMessage: 'Aucune passe décisive pour le moment',
          players: topAssists.take(5).toList(),
          statBuilder: (assister) => '${assister['assists']} passes',
          positionColor: AppColors.midfielder,
        );
      },
    );
  }

  Widget _buildPlayerListCard({
    required String title,
    required IconData icon,
    required String emptyMessage,
    required List<dynamic> players,
    required String Function(dynamic) statBuilder,
    required Color positionColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: positionColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppTextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            
            if (players.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    emptyMessage,
                    style: AppTextStyles.body2.copyWith(
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ...players.asMap().entries.map((entry) {
                final index = entry.key;
                final playerData = entry.value;
                final player = playerData['player'];
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: index == 0 ? positionColor.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: index == 0 ? positionColor : Colors.grey.shade200,
                      width: index == 0 ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Numéro du classement
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: index == 0 ? positionColor : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Numéro de maillot
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: positionColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${player.jerseyNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Nom du joueur
                      Expanded(
                        child: Text(
                          player.name,
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      // Statistique
                      Text(
                        statBuilder(playerData),
                        style: AppTextStyles.subtitle2.copyWith(
                          color: positionColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}