// lib/presentation/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/data/models/match.dart';
import 'package:team_manager_app/presentation/screens/notifications/notifications_screen.dart';
import 'package:team_manager_app/presentation/screens/players/player_detail_screen.dart';
import 'package:team_manager_app/presentation/screens/auth/login_screen.dart';
import '../../providers/auth_provider.dart';
import '../../providers/player_provider.dart';
import '../../providers/match_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/player.dart';
import '../../../data/models/user.dart';
import 'dart:math';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Consumer3<AuthProvider, PlayerProvider, MatchProvider>(
        builder: (context, authProvider, playerProvider, matchProvider, child) {
          final user = authProvider.currentUser;
          final player =
              user != null ? playerProvider.getPlayerById(user.id) : null;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                stretch: true,
                pinned: true,
                backgroundColor: AppColors.primary,
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  'MON PROFIL',
                  style: AppTextStyles.subtitle2.copyWith(
                    color: Colors.transparent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final top = constraints.biggest.height;
                    final isTitleVisible =
                        top < MediaQuery.of(context).size.height * 0.2;

                    return FlexibleSpaceBar(
                      centerTitle: false,
                      title: isTitleVisible
                          ? Text(
                              'MON PROFIL',
                              style: AppTextStyles.subtitle2.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const SizedBox.shrink(),
                      stretchModes: const [StretchMode.zoomBackground],
                      background: Container(
                        color: Colors.white,
                        child: Stack(
                          children: [
                            // Image de fond si disponible
                            if (user != null && user?.avatar != null)
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Image.asset(
                                  user!.avatar!,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            // Dégradé sombre en bas pour la lisibilité
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.95),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Avatar et informations
                            Positioned(
                              bottom: AppConstants.paddingLarge,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      user!.name,
                                      style: AppTextStyles.heading4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (player != null) ...[
                                      const SizedBox(
                                          height: AppConstants.paddingSmall),
                                      Text(
                                        _getPositionName(player.position),
                                        style: AppTextStyles.body1.copyWith(
                                          color: Colors.white.withOpacity(0.9),
                                          fontWeight: FontWeight.w500,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              blurRadius: 4,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    children: [
                      if (user != null) ...[
                        _buildUserInfoSection(user, player),
                        const SizedBox(height: AppConstants.paddingLarge),

                        // Section spécifique selon le type d'utilisateur
                        if (player != null)
                          _buildPlayerSections(player, matchProvider,context)
                        else if (authProvider.isCoach)
                          _buildCoachSections(matchProvider),

                        const SizedBox(height: AppConstants.paddingLarge),
                        _buildAppOptionsSection(context),
                        const SizedBox(height: AppConstants.paddingLarge),
                        _buildLogoutSection(context, authProvider),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileBackground(User user, Player? player) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                player != null
                    ? _getPositionColor(player.position)
                    : AppColors.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                backgroundImage:
                    player?.avatar != null ? AssetImage(player!.avatar!) : null,
                child: player?.avatar == null
                    ? Text(
                        user.name.substring(0, 1).toUpperCase(),
                        style: AppTextStyles.heading1.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoSection(User user, Player? player) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          children: [
            Text(
              user.name,
              style: AppTextStyles.heading3.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              user.email,
              style: AppTextStyles.body2.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLarge,
                vertical: AppConstants.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: _getUserTypeColor(user.type),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getUserTypeLabel(user.type),
                style: AppTextStyles.subtitle2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (player != null) ...[
              const SizedBox(height: AppConstants.paddingMedium),
              _buildPlayerQuickInfo(player),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerQuickInfo(Player player) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildInfoChip('N°${player.jerseyNumber}', Icons.confirmation_number),
        const SizedBox(width: AppConstants.paddingSmall),
        _buildInfoChip(_getPositionName(player.position), Icons.sports),
        const SizedBox(width: AppConstants.paddingSmall),
        _buildInfoChip('${player.age} ans', Icons.cake),
      ],
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSections(Player player, MatchProvider matchProvider, BuildContext context) {
    final playerStats = _getPlayerCompleteStats(player.id, matchProvider);
    final matchStats = _getPlayerMatchStats(player.id, matchProvider);

    return Column(
      children: [
        // Hexagone des statistiques
        _buildPlayerHexagonStats(player),
        const SizedBox(height: AppConstants.paddingLarge),

        // Statistiques de carrière
        _buildPlayerCareerStats(playerStats, matchStats,context),
        const SizedBox(height: AppConstants.paddingLarge),

        // Informations physiques
        _buildPlayerPhysicalInfo(player),
        const SizedBox(height: AppConstants.paddingLarge),

        // Historique des matchs récents
        _buildPlayerMatchHistory(player.id, matchProvider),
      ],
    );
  }

  Widget _buildCoachSections(MatchProvider matchProvider) {
    final teamStats = matchProvider.getTeamStatistics();

    return Column(
      children: [
        // Statistiques de l'équipe
        _buildTeamStatsCard(teamStats),
        const SizedBox(height: AppConstants.paddingLarge),

        // Actions rapides pour coach
        _buildCoachQuickActions(),
      ],
    );
  }

  Widget _buildTeamStatsCard(Map<String, dynamic> teamStats) {
    // Assurez-vous que toutes les clés existent
    final matchesPlayed = teamStats['matchesPlayed'] ?? 0;
    final wins = teamStats['wins'] ?? 0;
    final draws = teamStats['draws'] ?? 0;
    final losses = teamStats['losses'] ?? 0;
    final goalsFor = teamStats['goalsFor'] ?? 0;
    final goalsAgainst = teamStats['goalsAgainst'] ?? 0;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STATISTIQUES DE L\'ÉQUIPE',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
           LayoutBuilder(
  builder: (context, constraints) {
    // Déterminer le nombre de colonnes en fonction de la largeur
    final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
    
    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppConstants.paddingSmall,
      mainAxisSpacing: AppConstants.paddingSmall,
      childAspectRatio: constraints.maxWidth > 600 ? 1.5 : 2.2,
      children: [
        _buildStatCard('Matchs', '$matchesPlayed',context, Icons.sports_soccer),
        _buildStatCard('Victoires', '$wins',context, Icons.emoji_events,
            color: AppColors.win),
        _buildStatCard('Nuls', '$draws',context, Icons.horizontal_rule,
            color: AppColors.draw),
        _buildStatCard('Défaites', '$losses',context, Icons.close,
            color: AppColors.loss),
        _buildStatCard('Buts pour', '$goalsFor',context, Icons.sports_score,
            color: AppColors.excellent),
        _buildStatCard('Buts contre', '$goalsAgainst',context, Icons.shield,
            color: AppColors.error),
      ],
    );
  },
),
          ],
        ),
      ),
    );
  }

  Widget _buildCoachQuickActions() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ACTIONS RAPIDES',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Wrap(
              spacing: AppConstants.paddingSmall,
              runSpacing: AppConstants.paddingSmall,
              children: [
                _buildActionChip(
                    'Ajouter joueur', Icons.person_add, Colors.green),
                _buildActionChip('Créer match', Icons.event, Colors.blue),
                _buildActionChip('Voir effectif', Icons.people, Colors.orange),
                _buildActionChip(
                    'Statistiques', Icons.analytics, Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(String label, IconData icon, Color color) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
    );
  }

  Widget _buildPlayerHexagonStats(Player player) {
    final stats = player.stats;
    final statValues = [
      stats.pace.toDouble(),
      stats.shooting.toDouble(),
      stats.passing.toDouble(),
      stats.dribbling.toDouble(),
      stats.defending.toDouble(),
      stats.physical.toDouble(),
    ];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          children: [
            Text(
              'CARACTÉRISTIQUES',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: HexagonStatsPainter(statValues),
              ),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            Wrap(
              spacing: AppConstants.paddingSmall,
              runSpacing: AppConstants.paddingSmall,
              children: [
                _buildStatLegend('Vitesse', stats.pace, AppColors.excellent),
                _buildStatLegend('Tir', stats.shooting, AppColors.error),
                _buildStatLegend('Passes', stats.passing, AppColors.info),
                _buildStatLegend(
                    'Dribble', stats.dribbling, AppColors.secondary),
                _buildStatLegend('Défense', stats.defending, AppColors.good),
                _buildStatLegend('Physique', stats.physical, AppColors.warning),
              ],
            ),
          ],
        ),
      ),
    );
  }
Widget _buildPlayerCareerStats(
    Map<String, dynamic> playerStats, Map<String, dynamic> matchStats, BuildContext context) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
    ),
    child: Padding(
      padding: const EdgeInsets.all(AppConstants.paddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STATISTIQUES DE CARRIÈRE',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          LayoutBuilder(
            builder: (context, constraints) {
              // Déterminer le nombre de colonnes en fonction de la largeur
              final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              final childAspectRatio = constraints.maxWidth > 600 ? 1.5 : 2.2;
              
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: AppConstants.paddingSmall,
                mainAxisSpacing: AppConstants.paddingSmall,
                childAspectRatio: childAspectRatio,
                children: [
                  _buildStatCard('Matchs joués', '${matchStats['matchesPlayed']}', context,
                      Icons.sports_soccer),
                  _buildStatCard(
                      'Buts', '${playerStats['goals']}', context, Icons.sports_score),
                  _buildStatCard('Passes D', '${playerStats['assists']}', context,
                      Icons.assistant),
                  _buildStatCard(
                      'Titularisations', '${matchStats['starting']}', context, Icons.star),
                  _buildStatCard('Cartons jaunes',
                      '${playerStats['yellowCards']}', context, Icons.warning,
                      color: AppColors.warning),
                  _buildStatCard(
                      'Cartons rouges', '${playerStats['redCards']}', context, Icons.block,
                      color: AppColors.error),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}
  Widget _buildPlayerPhysicalInfo(Player player) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'INFORMATIONS PHYSIQUES',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            _buildInfoRow('Âge', '${player.age} ans'),
            _buildInfoRow('Taille', '180 cm'),
            _buildInfoRow('Poids', '75 kg'),
            _buildInfoRow('Pied fort', 'Droit'),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerMatchHistory(
      String playerId, MatchProvider matchProvider) {
    final matches = _getPlayerMatches(playerId, matchProvider);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DERNIERS MATCHS',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            ...matches.take(3).map((match) => _buildMatchRow(match, playerId)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppOptionsSection(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Column(
        children: [
          _buildOptionTile(
            context,
            'Notifications',
            Icons.notifications_active,
            Colors.blue,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            ),
          ),
          _buildDivider(),
          _buildOptionTile(
            context,
            'Préférences',
            Icons.settings,
            Colors.grey,
            () => _showInfo(context, 'Préférences de l\'application'),
          ),
          _buildDivider(),
          _buildOptionTile(
            context,
            'Aide et support',
            Icons.help,
            Colors.green,
            () => _showInfo(context, 'Aide et support'),
          ),
          _buildDivider(),
          _buildOptionTile(
            context,
            'À propos',
            Icons.info,
            Colors.purple,
            () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutSection(BuildContext context, AuthProvider authProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: AppColors.error.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showLogoutDialog(context, authProvider),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
          splashColor: AppColors.error.withOpacity(0.1),
          highlightColor: AppColors.error.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
              vertical: AppConstants.paddingMedium,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.error.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.error,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Se déconnecter',
                        style: AppTextStyles.subtitle1.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Quitter votre session en cours',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.error.withOpacity(0.7),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.error.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: AppTextStyles.subtitle1),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey.shade400,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade200,
    );
  }

  // Méthodes utilitaires existantes...
Widget _buildStatCard(String title, String value, BuildContext context, IconData icon,
    {Color color = AppColors.primary}) { 
  
  // Déterminer la hauteur en fonction de la taille de l'écran
  final bool isTablet = MediaQuery.of(context).size.width > 600;
  final double cardHeight = isTablet ? 32 : 70; // Réduit à 32 sur tablette
  final double iconSize = isTablet ? 14 : 20;
  final double padding = isTablet ? 4 : AppConstants.paddingMedium;
  
  return Container(
    padding: EdgeInsets.all(isTablet ? 4 : 8), // Padding réduit sur tablette
    height: cardHeight,
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: iconSize),
        SizedBox(width: padding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // Toujours centrer verticalement
            children: [
              if (!isTablet) // Sur mobile, afficher le titre au-dessus
                Text(
                  title,
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              Text(
                isTablet ? title : value,
                style: isTablet 
                  ? AppTextStyles.caption.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                    )
                  : AppTextStyles.heading5.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (isTablet) // Sur tablette, afficher la valeur en dessous
                Text(
                  value,
                  style: AppTextStyles.heading5.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12, // Taille réduite
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
 
  Widget _buildStatLegend(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: $value',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.body2.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyles.body1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchRow(Match match, String playerId) {
    final playerStats = match.playerStats?[playerId];
    final isStarter = match.startingEleven != null &&
        match.startingEleven!.contains(playerId);
    final result = match.result;
    final score = result != null
        ? '${result.isHomeTeam ? result.homeScore : result.awayScore}-${result.isHomeTeam ? result.awayScore : result.homeScore}'
        : 'N/A';

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'vs ${match.opponent}',
                  style: AppTextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatDate(match.dateTime),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isStarter ? AppColors.primary : AppColors.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isStarter ? 'Titulaire' : 'Remplaçant',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: _getResultColor(match),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              score,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (playerStats != null) ...[
            const SizedBox(width: AppConstants.paddingSmall),
            _buildStatIndicator('⚽', playerStats.goals),
            _buildStatIndicator('🎯', playerStats.assists),
            _buildStatIndicator('⭐', playerStats.rating.round()),
          ],
        ],
      ),
    );
  }

  Widget _buildStatIndicator(String emoji, int value) {
    if (value == 0) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$emoji$value',
        style: AppTextStyles.caption.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    final difference = today.difference(messageDate).inDays;

    if (difference == 0) return 'Aujourd\'hui';
    if (difference == 1) return 'Hier';
    if (difference < 7) return 'Il y a $difference jours';

    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getResultColor(Match match) {
    if (match.result == null) return Colors.grey;

    switch (match.result!.outcome) {
      case MatchOutcome.win:
        return AppColors.win;
      case MatchOutcome.draw:
        return AppColors.draw;
      case MatchOutcome.loss:
        return AppColors.loss;
    }
  }

// Méthodes pour récupérer les statistiques depuis la base de données
  Map<String, dynamic> _getPlayerCompleteStats(
      String playerId, MatchProvider matchProvider) {
    final matches = matchProvider.completedMatches;
    int goals = 0;
    int assists = 0;
    int yellowCards = 0;
    int redCards = 0;

    for (final match in matches) {
      if (match.playerStats != null &&
          match.playerStats!.containsKey(playerId)) {
        final stats = match.playerStats![playerId]!;
        goals += stats.goals;
        assists += stats.assists;
        yellowCards += stats.yellowCards;
        redCards += stats.redCards;
      }
    }

    return {
      'goals': goals,
      'assists': assists,
      'yellowCards': yellowCards,
      'redCards': redCards,
    };
  }

  Map<String, dynamic> _getPlayerMatchStats(
      String playerId, MatchProvider matchProvider) {
    final matches = matchProvider.completedMatches;
    int matchesPlayed = 0;
    int starting = 0;

    for (final match in matches) {
      if (match.selectedPlayers != null &&
          match.selectedPlayers!.contains(playerId)) {
        matchesPlayed++;
        if (match.startingEleven != null &&
            match.startingEleven!.contains(playerId)) {
          starting++;
        }
      }
    }

    return {
      'matchesPlayed': matchesPlayed,
      'starting': starting,
      'substitute': matchesPlayed - starting,
    };
  }

  List<Match> _getPlayerMatches(String playerId, MatchProvider matchProvider) {
    return matchProvider.completedMatches
        .where((match) =>
            match.selectedPlayers != null &&
            match.selectedPlayers!.contains(playerId))
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  Color _getPositionColor(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return AppColors.goalkeeper;
      case Position.defender:
        return AppColors.defender;
      case Position.midfielder:
        return AppColors.midfielder;
      case Position.forward:
        return AppColors.forward;
    }
  }

  String _getPositionName(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'Gardien';
      case Position.defender:
        return 'Défenseur';
      case Position.midfielder:
        return 'Milieu';
      case Position.forward:
        return 'Attaquant';
    }
  }

  Color _getUserTypeColor(UserType type) {
    switch (type) {
      case UserType.coach:
        return Colors.orange;
      case UserType.player:
        return AppColors.primary;
      default:
        return Colors.grey;
    }
  }

  String _getUserTypeLabel(UserType type) {
    switch (type) {
      case UserType.coach:
        return 'ENTRAÎNEUR';
      case UserType.player:
        return 'JOUEUR';
      default:
        return 'UTILISATEUR';
    }
  }

  void _showInfo(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(title)),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('À propos'),
        content: const Text(
          'Team Manager v1.0.0\n\n'
          'Application de gestion d\'équipe sportive.\n'
          'Gérez vos joueurs, matchs et statistiques facilement.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              authProvider.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
  }
}

// Custom painter pour l'hexagone des statistiques (identique à celui de player_detail_screen)
class HexagonStatsPainter extends CustomPainter {
  final List<double> stats;

  HexagonStatsPainter(this.stats);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.8;
    final points = <Offset>[];
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Dessiner l'hexagone de fond
    final backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 6; i++) {
      final angle = 2 * pi * i / 6 - pi / 2;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      points.add(Offset(x, y));
    }

    final backgroundPath = Path();
    backgroundPath.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      backgroundPath.lineTo(points[i].dx, points[i].dy);
    }
    backgroundPath.close();
    canvas.drawPath(backgroundPath, backgroundPaint);

    // Dessiner les lignes de grille
    final gridPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int level = 1; level <= 5; level++) {
      final levelRadius = radius * level / 5;
      final levelPoints = <Offset>[];

      for (int i = 0; i < 6; i++) {
        final angle = 2 * pi * i / 6 - pi / 2;
        final x = center.dx + levelRadius * cos(angle);
        final y = center.dy + levelRadius * sin(angle);
        levelPoints.add(Offset(x, y));
      }

      final levelPath = Path();
      levelPath.moveTo(levelPoints[0].dx, levelPoints[0].dy);
      for (int i = 1; i < levelPoints.length; i++) {
        levelPath.lineTo(levelPoints[i].dx, levelPoints[i].dy);
      }
      levelPath.close();
      canvas.drawPath(levelPath, gridPaint);
    }

    // Dessiner les lignes radiales
    for (final point in points) {
      canvas.drawLine(center, point, gridPaint);
    }

    // Dessiner le polygone des statistiques
    final statsPoints = <Offset>[];
    for (int i = 0; i < 6; i++) {
      final statValue = stats[i].clamp(0, 100);
      final statRadius = radius * statValue / 100;
      final angle = 2 * pi * i / 6 - pi / 2;
      final x = center.dx + statRadius * cos(angle);
      final y = center.dy + statRadius * sin(angle);
      statsPoints.add(Offset(x, y));
    }

    final statsPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final statsBorderPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final statsPath = Path();
    statsPath.moveTo(statsPoints[0].dx, statsPoints[0].dy);
    for (int i = 1; i < statsPoints.length; i++) {
      statsPath.lineTo(statsPoints[i].dx, statsPoints[i].dy);
    }
    statsPath.close();

    canvas.drawPath(statsPath, statsPaint);
    canvas.drawPath(statsPath, statsBorderPaint);

    // Ajouter les labels des statistiques
    final labels = ['VIT', 'TIR', 'PAS', 'DRI', 'DEF', 'PHY'];
    final labelStyle = TextStyle(
      color: AppColors.onSurface,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );

    for (int i = 0; i < 6; i++) {
      final angle = 2 * pi * i / 6 - pi / 2;
      final labelRadius = radius * 1.1;
      final x = center.dx + labelRadius * cos(angle);
      final y = center.dy + labelRadius * sin(angle);

      textPainter.text = TextSpan(text: labels[i], style: labelStyle);
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
