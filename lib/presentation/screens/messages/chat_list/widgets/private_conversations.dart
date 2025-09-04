// lib/presentation/screens/messages/components/private_conversations.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import './conversation_tile.dart';

class PrivateConversations extends StatelessWidget {
  final List<Message> conversations;
  final String currentUserId;
  final PlayerProvider playerProvider;

  const PrivateConversations({
    super.key,
    required this.conversations,
    required this.currentUserId,
    required this.playerProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final message = conversations[index];
        return ConversationTile(
          message: message,
          currentUserId: currentUserId,
          playerProvider: playerProvider,
        );
      },
    );
  }
}