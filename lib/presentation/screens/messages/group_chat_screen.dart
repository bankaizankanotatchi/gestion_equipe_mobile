// lib/presentation/screens/messages/group_chat_screen.dart
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
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).currentUser;
    final messageProvider = Provider.of<MessageProvider>(context);
    final playerProvider = Provider.of<PlayerProvider>(context);
    final messages = messageProvider.groupMessages;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DISCUSSION D\'ÉQUIPE',
              style: AppTextStyles.subtitle2.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              '${messages.length} messages • ${_getOnlineCount()} en ligne',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        elevation: 2,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, size: 22),
            onPressed: _showGroupInfo,
            tooltip: 'Informations du groupe',
          ),
          IconButton(
            icon: const Icon(Icons.people_alt, size: 22),
            onPressed: _showMembers,
            tooltip: 'Membres du groupe',
          ),
        ],
      ),
      body: Column(
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
                  ? _buildEmptyState()
                  : ListView.builder(
                      controller: _scrollController,
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
                            if (showDate) _buildDateSeparator(message.timestamp),
                            _buildMessageBubble(
                              message, 
                              isMe, 
                              showAvatar,
                              playerProvider,
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message, bool isMe, bool showAvatar, PlayerProvider playerProvider) {
    final isCoach = message.senderId.startsWith('coach');
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe && showAvatar)
            _buildUserAvatar(message.senderId, playerProvider, isCoach),
          if (!isMe && showAvatar) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe && showAvatar)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 4),
                    child: Text(
                      message.senderName,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: AppTextStyles.body1.copyWith(
                          color: isMe ? Colors.white : Colors.grey.shade800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(message.timestamp),
                        style: TextStyle(
                          color: isMe 
                            ? Colors.white.withOpacity(0.7)
                            : Colors.grey.shade500,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 8),
          if (isMe && showAvatar)
            _buildUserAvatar(message.senderId, playerProvider, isCoach),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(String userId, PlayerProvider playerProvider, bool isCoach) {
    final player = playerProvider.getPlayerById(userId);
    
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isCoach ? Colors.amber : AppColors.primary,
          width: isCoach ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: isCoach ? Colors.amber.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
        backgroundImage: player?.avatar != null ? AssetImage(player!.avatar!) : null,
        child: player?.avatar == null
            ? Text(
                isCoach ? 'C' : 'J',
                style: TextStyle(
                  color: isCoach ? Colors.amber : AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildDateSeparator(DateTime date) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _formatDate(date),
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Écrivez un message...',
                        hintStyle: AppTextStyles.body2.copyWith(
                          color: Colors.grey.shade500,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                      onSubmitted: (_) => _sendMessage(),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  if (_messageController.text.isEmpty)
                    IconButton(
                      icon: Icon(Icons.emoji_emotions, color: Colors.grey.shade500),
                      onPressed: () {},
                    ),
                  if (_messageController.text.isEmpty)
                    IconButton(
                      icon: Icon(Icons.attach_file, color: Colors.grey.shade500),
                      onPressed: () {},
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: _messageController.text.isEmpty
                  ? null
                  : const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: _messageController.text.isEmpty
                  ? Colors.grey.shade300
                  : null,
            ),
            child: IconButton(
              icon: Icon(
                _messageController.text.isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
                size: 20,
              ),
              onPressed: _messageController.text.isEmpty ? null : _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.forum_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Démarrez la conversation !',
            style: AppTextStyles.heading5.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Envoyez le premier message à l\'équipe',
            style: AppTextStyles.body2.copyWith(
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          FloatingActionButton(
            onPressed: () {
              _focusNode.requestFocus();
            },
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add_comment, color: Colors.white),
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
    );

    Provider.of<MessageProvider>(context, listen: false).sendGroupMessage(message);
    _messageController.clear();
    _scrollToBottom();
    setState(() {});
  }

  bool _shouldShowAvatar(List<Message> messages, int index) {
    if (index == 0) return true;
    
    final currentMessage = messages[index];
    final previousMessage = messages[index - 1];
    
    // Montrer l'avatar si le message précédent est d'un autre expéditeur
    // ou si plus de 5 minutes se sont écoulées
    return currentMessage.senderId != previousMessage.senderId ||
        currentMessage.timestamp.difference(previousMessage.timestamp).inMinutes > 5;
  }

  bool _shouldShowDate(List<Message> messages, int index) {
    if (index == 0) return true;
    
    final currentDate = messages[index].timestamp;
    final previousDate = messages[index - 1].timestamp;
    
    // Montrer la date si le jour est différent
    return currentDate.day != previousDate.day ||
        currentDate.month != previousDate.month ||
        currentDate.year != previousDate.year;
  }

  String _formatTime(DateTime timestamp) {
    return DateFormat('HH:mm').format(timestamp);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);
    
    final difference = today.difference(messageDate).inDays;
    
    if (difference == 0) return 'Aujourd\'hui';
    if (difference == 1) return 'Hier';
    if (difference < 7) return 'Il y a $difference jours';
    
    return DateFormat('dd MMMM yyyy').format(date);
  }

  int _getOnlineCount() {
    // Simulation - dans une vraie app, vous auriez un système de présence
    return 8 + DateTime.now().second % 5; // Nombre aléatoire entre 8 et 12
  }

  void _showGroupInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discussion d\'équipe'),
        content: const Text(
          'Tous les membres de l\'équipe peuvent participer à cette conversation. '
          'Les coachs et les joueurs peuvent échanger des informations importantes.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showMembers() {
    // Navigation vers l'écran des membres
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à venir')),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}