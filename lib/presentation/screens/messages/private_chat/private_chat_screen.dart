// lib/presentation/screens/messages/private_chat/private_chat_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/message_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/data/models/user.dart';
import 'content/private_chat_content.dart';

@RoutePage()
class PrivateChatScreen extends StatefulWidget {
  final String userId;

  const PrivateChatScreen({super.key, required this.userId});

  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  User? _recipient;
  Map<String, User> _userCache = {};

  @override
  void initState() {
    super.initState();
    _loadRecipient();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _loadRecipient() async {
    final user = await Provider.of<AuthProvider>(context, listen: false)
        .getUserById(widget.userId);
    if (user != null) {
      setState(() {
        _recipient = user;
        _userCache[user.id] = user;
      });
    }
  }

  void _preloadUsers(List<Message> messages) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    for (var msg in messages) {
      if (!_userCache.containsKey(msg.senderId)) {
        final user = await authProvider.getUserById(msg.senderId);
        if (user != null) {
          _userCache[msg.senderId] = user;
        }
      }
    }
    setState(() {});
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
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
      recipientId: widget.userId,
    );

    Provider.of<MessageProvider>(context, listen: false).sendPrivateMessage(message);
    _messageController.clear();
    _scrollToBottom();
  }

  String _getUserStatus(User user) {
    if (user.type == UserType.coach) {
      return 'Entraîneur';
    } else {
      final player = Provider.of<PlayerProvider>(context, listen: false)
          .getPlayerById(user.id);
      return player?.position.name ?? 'Joueur';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).currentUser;

    return FutureBuilder<User?>(
      future: Provider.of<AuthProvider>(context, listen: false)
          .getUserById(widget.userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final recipient = snapshot.data!;
        final messages = Provider.of<MessageProvider>(context)
            .getPrivateChat(currentUser?.id ?? '', recipient.id);

        _preloadUsers(messages);

        return PrivateChatContent(
          recipient: recipient,
          messages: messages,
          currentUser: currentUser,
          messageController: _messageController,
          scrollController: _scrollController,
          userCache: _userCache,
          getUserStatus: _getUserStatus,
          onSendMessage: _sendMessage,
        );
      },
    );
  }
}