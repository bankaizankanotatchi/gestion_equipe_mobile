// lib/presentation/screens/messages/private_chat/content/private_chat_content.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/data/models/user.dart';
import '../widgets/Message_Bubble.dart';
import '../widgets/Message_input.dart';
import '../widgets/private_chat_app_bar.dart';
import '../widgets/message_input.dart';

class PrivateChatContent extends StatelessWidget {
  final User recipient;
  final List<Message> messages;
  final User? currentUser;
  final TextEditingController messageController;
  final ScrollController scrollController;
  final Map<String, User> userCache;
  final String Function(User) getUserStatus;
  final VoidCallback onSendMessage;

  const PrivateChatContent({
    super.key,
    required this.recipient,
    required this.messages,
    required this.currentUser,
    required this.messageController,
    required this.scrollController,
    required this.userCache,
    required this.getUserStatus,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrivateChatAppBar(
        recipient: recipient,
        getUserStatus: getUserStatus,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message.senderId == currentUser?.id;
                return MessageBubble(
                  message: message,
                  isMe: isMe,
                  user: userCache[message.senderId],
                );
              },
            ),
          ),
          MessageInput(
            messageController: messageController,
            onSendMessage: onSendMessage,
          ),
        ],
      ),
    );
  }
}