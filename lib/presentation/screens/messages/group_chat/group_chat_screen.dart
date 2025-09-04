// lib/presentation/screens/messages/group_chat/group_chat_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/message_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/presentation/screens/messages/group_chat/widgets/group_chat_app_bar.dart';
import './content/group_chat_content.dart';

@RoutePage()
class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(animated: false);
    });
  }

  void _scrollToBottom({bool animated = true}) {
    if (_scrollController.hasClients) {
      if (animated) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const GroupChatAppBar(),
      body: Consumer3<AuthProvider, MessageProvider, PlayerProvider>(
        builder: (context, authProvider, messageProvider, playerProvider, child) {
          return GroupChatContent(
            authProvider: authProvider,
            messageProvider: messageProvider,
            playerProvider: playerProvider,
            messageController: _messageController,
            scrollController: _scrollController,
            focusNode: _focusNode,
            onSendMessage: _sendMessage,
            onScrollToBottom: _scrollToBottom,
          );
        },
      ),
    );
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final currentUser = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (currentUser == null) return;

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: currentUser.id,
      senderName: currentUser.name,
      content: content,
      timestamp: DateTime.now(),
      type: MessageType.text,
    );

    Provider.of<MessageProvider>(context, listen: false).sendGroupMessage(message);
    _messageController.clear();
    _scrollToBottom();
    setState(() {});
  }
}