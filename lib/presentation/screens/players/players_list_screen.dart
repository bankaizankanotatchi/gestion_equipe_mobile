// lib/presentation/screens/players/players_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/screens/players/player_detail_screen.dart';
import '../../providers/auth_provider.dart';
import '../../providers/player_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/player.dart';

class PlayersListScreen extends StatefulWidget {
  const PlayersListScreen({super.key});

  @override
  State<PlayersListScreen> createState() => _PlayersListScreenState();
}

class _PlayersListScreenState extends State<PlayersListScreen> {
  String _searchQuery = '';
  Position? _selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Joueurs', 
          style: AppTextStyles.heading5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
            color: Colors.white,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
            color: Colors.white,
          ),
        ],
      ),
      body: Consumer<PlayerProvider>(
        builder: (context, playerProvider, child) {
          final players = _getFilteredPlayers(playerProvider.players);
          
          if (players.isEmpty) {
            return _buildEmptyState();
          }

          return Padding(
            padding: const EdgeInsets.all(AppConstants.paddingSmall),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: AppConstants.paddingSmall,
                mainAxisSpacing: AppConstants.paddingSmall,
                childAspectRatio: 0.75,
              ),
              itemCount: players.length,
              itemBuilder: (context, index) {
                return _buildPlayerCard(players[index]);
              },
            ),
          );
        },
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) {
      return 3; // Tablettes
    }
    return 2; // Mobiles
  }

  List<Player> _getFilteredPlayers(List<Player> players) {
    return players.where((player) {
      final matchesSearch = _searchQuery.isEmpty ||
          player.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesPosition = _selectedPosition == null ||
          player.position == _selectedPosition;
      return matchesSearch && matchesPosition;
    }).toList();
  }

 Widget _buildPlayerCard(Player player) {
  return GestureDetector(
    onTap: () => _navigateToPlayerDetail(player),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Image de fond de l'avatar
          if (player?.avatar != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
              child: Image.asset(
                player!.avatar!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          
          // Dégradé sombre en bas pour améliorer la lisibilité du texte
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppConstants.borderRadiusLarge),
                  bottomRight: Radius.circular(AppConstants.borderRadiusLarge),
                ),
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
          
          // Background pattern (optionnel, plus discret)
          const Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.05,
              child: Icon(
                Icons.sports_soccer,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          
          // Contenu du joueur (positionné en absolu en bas)
          Positioned(
            bottom: AppConstants.paddingSmall,
            left: AppConstants.paddingSmall,
            right: AppConstants.paddingSmall,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom du joueur
                Text(
                  player.name,
                  style: AppTextStyles.heading5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: AppConstants.paddingSmall),
                
                // Rating
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingSmall,
                        vertical: AppConstants.paddingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${player.overallRating.round()}',
                            style: AppTextStyles.subtitle2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2,),
                                    // Position
                Text(
                  _getPositionName(player.position),
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                
                  ],
                ),
              ],
            ),
          ),
          
          // Numéro de maillot en haut à droite
          Positioned(
            top: AppConstants.paddingMedium,
            right: AppConstants.paddingMedium,
            child: Text(
              '#${player.jerseyNumber}',
              style: AppTextStyles.heading3.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.9),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          
          // Accent coin supérieur gauche
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppConstants.borderRadiusLarge),
                  bottomRight: Radius.circular(AppConstants.borderRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_outlined,
            size: 64,
            color: AppColors.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            'Aucun joueur trouvé',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            'Ajustez vos filtres ou ajoutez de nouveaux joueurs',
            style: AppTextStyles.body2.copyWith(
              color: AppColors.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
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

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rechercher un joueur'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Nom du joueur...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrer par position'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: Position.values.map((position) {
            return RadioListTile<Position?>(
              title: Text(_getPositionName(position)),
              value: position,
              groupValue: _selectedPosition,
              onChanged: (value) {
                setState(() {
                  _selectedPosition = value;
                });
                Navigator.pop(context);
              },
            );
          }).toList()..insert(0, 
            RadioListTile<Position?>(
              title: const Text('Toutes les positions'),
              value: null,
              groupValue: _selectedPosition,
              onChanged: (value) {
                setState(() {
                  _selectedPosition = value;
                });
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPlayerDetail(Player player) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerDetailScreen(playerId: player.id),
      ),
    );
  }
}