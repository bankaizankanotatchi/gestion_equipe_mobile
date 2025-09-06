// lib/presentation/screens/messages/new_chat/content/new_chat_content.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/user.dart';
import '../widgets/Filter_Chips.dart';
import '../widgets/search_bar.dart';
import '../widgets/filter_chips.dart';
import '../widgets/user_list.dart';
import '../widgets/empty_state.dart';

class NewChatContent extends StatelessWidget {
  final User currentUser;
  final PlayerProvider playerProvider;
  final TextEditingController searchController;
  final String searchQuery;
  final UserType selectedFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<UserType> onFilterChanged;

  const NewChatContent({
    super.key,
    required this.currentUser,
    required this.playerProvider,
    required this.searchController,
    required this.searchQuery,
    required this.selectedFilter,
    required this.onSearchChanged,
    required this.onFilterChanged,
  });

  // Méthodes pour récupérer les données (à adapter selon votre implémentation)
  List<User> _getCoaches() {
    return [
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
  }

  List<User> _getAvailableUsers() {
    final coaches = _getCoaches();
    final playersAsUsers = playerProvider.players.map((player) {
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
      return selectedFilter == UserType.player || user.type == selectedFilter;
    }).toList();

    // Filtrer par recherche
    if (searchQuery.isNotEmpty) {
      availableUsers = availableUsers.where((user) {
        return user.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            user.email.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Trier : coachs d'abord, puis joueurs
    availableUsers.sort((a, b) {
      if (a.type == UserType.coach && b.type != UserType.coach) return -1;
      if (a.type != UserType.coach && b.type == UserType.coach) return 1;
      return a.name.compareTo(b.name);
    });

    return availableUsers;
  }

  @override
  Widget build(BuildContext context) {
    final availableUsers = _getAvailableUsers();

    return Column(
      children: [
        // Barre de recherche
        SearchBar(
          controller: searchController,
          onChanged: onSearchChanged,
        ),

        // Filtres (seulement pour les coachs)
        if (currentUser.type == UserType.coach)
          FilterChips(
            selectedFilter: selectedFilter,
            onFilterChanged: onFilterChanged,
          ),

        // Liste des utilisateurs
        Expanded(
          child: availableUsers.isEmpty
              ? EmptyState(searchQuery: searchQuery)
              : UserList(
            users: availableUsers,
            playerProvider: playerProvider,
            currentUser: currentUser,
          ),
        ),
      ],
    );
  }
}