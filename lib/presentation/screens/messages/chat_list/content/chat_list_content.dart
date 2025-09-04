// lib/presentation/screens/messages/content/chat_list_content.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/message_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list/widgets/empty_conversations.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list/widgets/error_state.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list/widgets/group_chat_tile.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list/widgets/loading_state.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list/widgets/private_conversations.dart';

class ChatListContent extends StatelessWidget {
  final AuthProvider authProvider;
  final MessageProvider messageProvider;
  final PlayerProvider playerProvider;

  const ChatListContent({
    super.key,
    required this.authProvider,
    required this.messageProvider,
    required this.playerProvider,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = authProvider.currentUser;
    if (currentUser == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        // Groupe de discussion
        GroupChatTile(messageProvider: messageProvider),
        const Divider(height: 1),
        // Header conversations privées
        _buildPrivateConversationsHeader(context),
        // Conversations privées
        Expanded(
          child: _buildPrivateConversations(context, currentUser.id),
        ),
      ],
    );
  }

  Widget _buildPrivateConversationsHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      child: Row(
        children: [
          Text(
            'CONVERSATIONS PRIVÉES',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          if (authProvider.isCoach)
            TextButton(
              onPressed: () => _startNewChat(context),
              child: Text(
                'Nouveau',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPrivateConversations(BuildContext context, String userId) {
    return FutureBuilder<List<Message>>(
      future: messageProvider.getConversationsForUser(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingState();
        }
        if (snapshot.hasError) {
          return ErrorState(message: 'Erreur de chargement');
        }

        final conversations = snapshot.data ?? [];

        if (conversations.isEmpty) {
          return EmptyConversations(isCoach: authProvider.isCoach);
        }

        return PrivateConversations(
          conversations: conversations,
          currentUserId: userId,
          playerProvider: playerProvider,
        );
      },
    );
  }

  void _startNewChat(BuildContext context) {
    context.router.push(const NewChatRoute());
  }
}