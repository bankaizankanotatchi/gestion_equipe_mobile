// lib/presentation/screens/messages/chat_list_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/presentation/screens/messages/chat_list/widgets/chat_app_bar.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/message_provider.dart';
import '../../../providers/player_provider.dart';
import './content/chat_list_content.dart';

@RoutePage()
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      floatingActionButton: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isCoach) {
            return FloatingActionButton(
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () => _startNewChat(context),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: Consumer3<AuthProvider, MessageProvider, PlayerProvider>(
        builder: (context, authProvider, messageProvider, playerProvider, child) {
          return ChatListContent(
            authProvider: authProvider,
            messageProvider: messageProvider,
            playerProvider: playerProvider,
          );
        },
      ),
    );
  }

  void _startNewChat(BuildContext context) {
    context.router.push(const NewChatRoute());
  }
}