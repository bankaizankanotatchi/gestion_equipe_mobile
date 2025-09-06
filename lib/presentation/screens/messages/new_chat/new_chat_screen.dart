// lib/presentation/screens/messages/new_chat/new_chat_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/user.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import 'content/new_chat_content.dart';

@RoutePage()
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

          return NewChatContent(
            currentUser: currentUser,
            playerProvider: playerProvider,
            searchController: _searchController,
            searchQuery: _searchQuery,
            selectedFilter: _selectedFilter,
            onSearchChanged: (value) => setState(() => _searchQuery = value),
            onFilterChanged: (filter) => setState(() => _selectedFilter = filter),
          );
        },
      ),
    );
  }
}