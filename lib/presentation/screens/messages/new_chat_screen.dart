// lib/presentation/screens/messages/new_chat_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/data/models/user.dart';
import 'package:team_manager_app/presentation/screens/messages/private_chat_screen.dart';
import '../../providers/auth_provider.dart';
import '../../providers/player_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  UserType _selectedFilter = UserType.player;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOUVELLE CONVERSATION',
          style: AppTextStyles.heading4.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer2<AuthProvider, PlayerProvider>(
        builder: (context, authProvider, playerProvider, child) {
          final currentUser = authProvider.currentUser;
          if (currentUser == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Récupérer tous les utilisateurs disponibles (coachs et joueurs)
          // Note: Dans votre implémentation actuelle, vous n'avez pas de UserProvider
          // Nous allons donc utiliser les joueurs du PlayerProvider et ajouter les coachs manuellement
          
          // Liste des coachs (hardcodée pour l'instant - à adapter selon votre structure de données)
          final List<User> coaches = [
            User(
              id: 'coach1',
              name: 'Jean Dubois',
              email: 'jean.dubois@team.com',
              password: 'coach123',
              type: UserType.coach,
              avatar: 'assets/avatars/coach1.jpg',
              createdAt: DateTime(2024, 1, 15),
            ),
            User(
              id: 'coach2',
              name: 'Marie Martin',
              email: 'marie.martin@team.com',
              password: 'coach456',
              type: UserType.coach,
              avatar: 'assets/avatars/coach2.jpg',
              createdAt: DateTime(2024, 1, 16),
            ),
          ];

          // Convertir les joueurs en users
          final List<User> playersAsUsers = playerProvider.players.map((player) {
            return User(
              id: player.id,
              name: player.name,
              email: '${player.name.toLowerCase().replaceAll(' ', '.')}@team.com',
              password: 'player123',
              type: UserType.player,
              avatar: player.avatar,
              createdAt: player.joinDate,
            );
          }).toList();

          // Combiner coachs et joueurs
          List<User> allUsers = [...coaches, ...playersAsUsers];

          // Filtrer les utilisateurs selon le type et les permissions
          List<User> availableUsers = allUsers.where((user) {
            // Un utilisateur ne peut pas se parler à lui-même
            if (user.id == currentUser.id) return false;
            
            // Les joueurs ne peuvent parler qu'aux coachs
            if (currentUser.type == UserType.player) {
              return user.type == UserType.coach;
            }
            
            // Les coachs peuvent parler à tout le monde
            return _selectedFilter == "Tous"|| user.type == _selectedFilter;
          }).toList();

          // Filtrer par recherche
          if (_searchQuery.isNotEmpty) {
            availableUsers = availableUsers.where((user) {
              return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                     user.email.toLowerCase().contains(_searchQuery.toLowerCase());
            }).toList();
          }

          // Trier : coachs d'abord, puis joueurs
          availableUsers.sort((a, b) {
            if (a.type == UserType.coach && b.type != UserType.coach) return -1;
            if (a.type != UserType.coach && b.type == UserType.coach) return 1;
            return a.name.compareTo(b.name);
          });

          return Column(
            children: [
              // Barre de recherche
              _buildSearchBar(),
              
              // Filtres (seulement pour les coachs)
              if (currentUser.type == UserType.coach)
                _buildFilterChips(),
              
              // Liste des utilisateurs
              Expanded(
                child: availableUsers.isEmpty
                    ? _buildEmptyState()
                    : _buildUserList(availableUsers, playerProvider, currentUser),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher un membre...',
          hintStyle: AppTextStyles.body2.copyWith(
            color: Colors.grey.shade500,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey.shade500),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding:  EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: AppTextStyles.caption.fontSize! / 2,
          ),
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      color: Colors.grey.shade50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              'Filtrer: ',
              style: AppTextStyles.caption.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            ...UserType.values.where((type) => type != "Tous").map((type) {
              final isSelected = _selectedFilter == type;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(
                    _getUserTypeLabel(type),
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected ? Colors.white : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) => setState(() {
                    _selectedFilter = selected ? type : UserType.player;
                  }),
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.primary,
                  side: BorderSide(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  checkmarkColor: Colors.white,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(List<User> users, PlayerProvider playerProvider, User currentUser) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final player = playerProvider.getPlayerById(user.id);
        
        return _buildUserTile(user, player, currentUser);
      },
    );
  }

  Widget _buildUserTile(User user, Player? player, User currentUser) {
    final isCoach = user.type == UserType.coach;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: _buildUserAvatar(user, player),
        title: Text(
          user.name,
          style: AppTextStyles.subtitle1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isCoach ? 'Entraîneur' : 'Joueur',
              style: AppTextStyles.caption.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            if (player != null && !isCoach)
              Text(
                '${_getPositionName(player.position)} • N°${player.jerseyNumber}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary.withOpacity(0.7),
                ),
              ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.chat,
            size: 18,
            color: AppColors.primary,
          ),
        ),
        onTap: () => _startChatWithUser(user),
      ),
    );
  }

  Widget _buildUserAvatar(User user, Player? player) {
    final isCoach = user.type == UserType.coach;
    final avatarColor = _getAvatarColor(user.id);
    
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: avatarColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: avatarColor.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: player?.avatar != null
              ? CircleAvatar(
                  backgroundImage: AssetImage(player!.avatar!),
                  radius: 24,
                )
              : Center(
                  child: Text(
                    user.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
        ),
        if (isCoach)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(
                Icons.star,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_off,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Text(
            _searchQuery.isEmpty ? 'Aucun membre disponible' : 'Aucun résultat',
            style: AppTextStyles.heading5.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            _searchQuery.isEmpty
                ? 'Tous les membres sont déjà en conversation'
                : 'Aucun membre ne correspond à "$_searchQuery"',
            style: AppTextStyles.body2.copyWith(
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getUserTypeLabel(UserType type) {
    switch (type) {
      case UserType.coach:
        return 'Entraîneurs';
      case UserType.player:
        return 'Joueurs';
      default:
        return 'Tous';
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

  Color _getAvatarColor(String userId) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.indigo,
    ];
    final index = userId.hashCode % colors.length;
    return colors[index];
  }

  void _startChatWithUser(User user) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PrivateChatScreen(userId: user.id),
    //   ),
    // );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Nouvelle discussion avec ${user.name}"),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}