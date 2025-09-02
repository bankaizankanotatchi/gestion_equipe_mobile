// lib/presentation/screens/messages/private_chat_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/message_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/data/models/user.dart';

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
  Map<String, User> _userCache = {}; // stocke les autres utilisateurs par ID

   @override
  void initState() {
    super.initState();
    _loadRecipient();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

    void _loadRecipient() async {
    // récupère le destinataire principal
    final user = await Provider.of<AuthProvider>(context, listen: false)
        .getUserById(widget.userId);
    if (user != null) {
      setState(() {
        _recipient = user;
        _userCache[user.id] = user; // ajoute au cache
      });
    }
  }

    // précharger les avatars des autres utilisateurs du chat
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
    setState(() {}); // force rebuild pour afficher les avatars
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

          // précharge les autres utilisateurs
_preloadUsers(messages);

      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(recipient.avatar ?? 'assets/avatars/default_avatar.jpg'),
              ),
              const SizedBox(width: AppConstants.paddingMedium),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipient.name, style: AppTextStyles.subtitle1),
                  Text(
                    _getUserStatus(recipient),
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: AppColors.surface,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.videocam),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message.senderId == currentUser?.id;
                  return _buildMessageBubble(message, isMe);
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      );
    },
  );
}

  Widget _buildMessageBubble(Message message, bool isMe) {
    final user = _userCache[message.senderId];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(
              user?.avatar ?? 'assets/avatars/default_avatar.jpg',
            ),
          ),
          if (!isMe) const SizedBox(width: AppConstants.paddingSmall),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.surfaceVariant,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppConstants.borderRadiusLarge),
                  topRight: const Radius.circular(AppConstants.borderRadiusLarge),
                  bottomLeft: isMe 
                    ? const Radius.circular(AppConstants.borderRadiusLarge)
                    : const Radius.circular(AppConstants.borderRadiusSmall),
                  bottomRight: isMe 
                    ? const Radius.circular(AppConstants.borderRadiusSmall)
                    : const Radius.circular(AppConstants.borderRadiusLarge),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: AppTextStyles.messageContent.copyWith(
                      color: isMe ? AppColors.onPrimary : AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: AppTextStyles.messageTime.copyWith(
                      color: isMe 
                        ? AppColors.onPrimary.withOpacity(0.7)
                        : AppColors.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: AppConstants.paddingSmall),
          if (!isMe)
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(
              user?.avatar ?? 'assets/avatars/default_avatar.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.onSurface.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Écrivez un message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                  vertical: AppConstants.paddingSmall,
                ),
              ),
              maxLines: null,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          IconButton(
            icon: const Icon(Icons.emoji_emotions),
            onPressed: () {},
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: AppColors.onPrimary),
              onPressed: _sendMessage,
            ),
          ),
        ],
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

  String _formatTime(DateTime timestamp) {
    return DateFormat('HH:mm').format(timestamp);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}