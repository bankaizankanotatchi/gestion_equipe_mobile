// lib/presentation/screens/messages/group_chat/content/group_chat_content.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/message_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/presentation/screens/messages/group_chat/widgets/date_separator.dart';
import 'package:team_manager_app/presentation/screens/messages/group_chat/widgets/empty_chat.dart';
import 'package:team_manager_app/presentation/screens/messages/group_chat/widgets/message_bubble.dart';
import 'package:team_manager_app/presentation/screens/messages/group_chat/widgets/message_input.dart';

class GroupChatContent extends StatelessWidget {
  final AuthProvider authProvider;
  final MessageProvider messageProvider;
  final PlayerProvider playerProvider;
  final TextEditingController messageController;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final VoidCallback onSendMessage;
  final Function({bool animated}) onScrollToBottom;

  const GroupChatContent({
    super.key,
    required this.authProvider,
    required this.messageProvider,
    required this.playerProvider,
    required this.messageController,
    required this.scrollController,
    required this.focusNode,
    required this.onSendMessage,
    required this.onScrollToBottom,
  });

  @override
  Widget build(BuildContext context) {
    final messages = messageProvider.groupMessages;
    final currentUser = authProvider.currentUser;

    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withOpacity(0.03),
                  Colors.grey.shade100,
                ],
              ),
            ),
            child: messages.isEmpty
                ? EmptyChat(
                    onStartChat: () {
                      focusNode.requestFocus();
                    },
                  )
                : ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingMedium,
                      vertical: AppConstants.paddingSmall,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderId == currentUser?.id;
                      final showAvatar = _shouldShowAvatar(messages, index);
                      final showDate = _shouldShowDate(messages, index);
                      
                      return Column(
                        children: [
                          if (showDate) DateSeparator(timestamp: message.timestamp),
                          MessageBubble(
                            message: message,
                            isMe: isMe,
                            showAvatar: showAvatar,
                            playerProvider: playerProvider,
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
        MessageInput(
          controller: messageController,
          focusNode: focusNode,
          onSendMessage: onSendMessage,
        ),
      ],
    );
  }

  bool _shouldShowAvatar(List<Message> messages, int index) {
    if (index == 0) return true;
    
    final currentMessage = messages[index];
    final previousMessage = messages[index - 1];
    
    return currentMessage.senderId != previousMessage.senderId ||
        currentMessage.timestamp.difference(previousMessage.timestamp).inMinutes > 5;
  }

  bool _shouldShowDate(List<Message> messages, int index) {
    if (index == 0) return true;
    
    final currentDate = messages[index].timestamp;
    final previousDate = messages[index - 1].timestamp;
    
    return currentDate.day != previousDate.day ||
        currentDate.month != previousDate.month ||
        currentDate.year != previousDate.year;
  }
}