// lib/presentation/screens/messages/chat_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/data/models/message.dart';
import 'package:team_manager_app/presentation/screens/messages/group_chat_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/private_chat_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/new_chat_screen.dart';
import '../../providers/auth_provider.dart';
import '../../providers/message_provider.dart';
import '../../providers/player_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MESSAGERIE', style: AppTextStyles.heading4.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MessageSearchDelegate(),
              );
            },
          ),
        ],
      ),
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
          final currentUser = authProvider.currentUser;
          if (currentUser == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Groupe de discussion
              _buildGroupChatTile(context),
              const Divider(height: 1),
              // Header conversations privées
              Padding(
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
              ),
              // Conversations privées
              Expanded(
                child: _buildPrivateConversations(context, authProvider, messageProvider, playerProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGroupChatTile(BuildContext context) {
    return Consumer<MessageProvider>(
      builder: (context, messageProvider, child) {
        final lastMessage = messageProvider.groupMessages.isNotEmpty 
            ? messageProvider.groupMessages.last 
            : null;
            
        return Container(
          margin: const EdgeInsets.all(AppConstants.paddingSmall),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.group,
                color: Colors.white,
                size: 24,
              ),
            ),
            title: Text(
              'Discussion d\'équipe',
              style: AppTextStyles.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: lastMessage != null
                ? Text(
                    lastMessage.content,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.onSurface.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(
                    'Tous les membres de l\'équipe',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.onSurface.withOpacity(0.7),
                    ),
                  ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (lastMessage != null)
                  Text(
                    _formatTime(lastMessage.timestamp),
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onSurface.withOpacity(0.5),
                    ),
                  ),
                const SizedBox(height: 4),
                if (messageProvider.groupMessages.any((msg) => !msg.isRead))
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            onTap: () => _openGroupChat(context),
          ),
        );
      },
    );
  }

  Widget _buildPrivateConversations(
    BuildContext context,
    AuthProvider authProvider,
    MessageProvider messageProvider,
    PlayerProvider playerProvider,
  ) {
    final userId = authProvider.currentUser?.id ?? '';

    return FutureBuilder<List<Message>>(
      future: messageProvider.getConversationsForUser(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.error,
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Text(
                  'Erreur de chargement',
                  style: AppTextStyles.heading5.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          );
        }

        final conversations = snapshot.data ?? [];
        final filteredConversations = conversations.where((conv) {
          final otherPersonName = _getOtherPersonName(conv, userId);
          return otherPersonName.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

        if (filteredConversations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: AppColors.onSurface.withOpacity(0.3),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Text(
                  authProvider.isCoach 
                    ? 'Commencez une discussion avec vos joueurs'
                    : 'Aucune conversation privée',
                  style: AppTextStyles.heading5.copyWith(
                    color: AppColors.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingSmall),
                if (authProvider.isCoach)
                  ElevatedButton(
                    onPressed: () => _startNewChat(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Nouvelle conversation'),
                  ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredConversations.length,
          itemBuilder: (context, index) {
            final message = filteredConversations[index];
            return _buildConversationTile(context, message, userId, playerProvider);
          },
        );
      },
    );
  }

  Widget _buildConversationTile(
    BuildContext context, 
    Message message, 
    String currentUserId,
    PlayerProvider playerProvider,
  ) {
    final isFromCurrentUser = message.senderId == currentUserId;
    final otherPersonId = isFromCurrentUser ? message.recipientId : message.senderId;
    final otherPersonName = isFromCurrentUser ? message.recipientId : message.senderName;
    
    // Récupérer les infos du joueur pour l'avatar
    final player = otherPersonId != null ? playerProvider.getPlayerById(otherPersonId) : null;
    final avatarText = otherPersonName!.substring(0, 1).toUpperCase();

    return Dismissible(
      key: Key(message.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Supprimer la conversation'),
            content: const Text('Êtes-vous sûr de vouloir supprimer cette conversation ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text('Supprimer'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        // TODO: Implémenter la suppression de la conversation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Conversation avec $otherPersonName supprimée')),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: player?.avatar != null
              ? CircleAvatar(
                  backgroundImage: AssetImage(player!.avatar!),
                  radius: 24,
                )
              : CircleAvatar(
                  backgroundColor: _getAvatarColor(otherPersonId ?? ''),
                  radius: 24,
                  child: Text(
                    avatarText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
          title: Text(
            otherPersonName,
            style: AppTextStyles.subtitle1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            message.content,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.onSurface.withOpacity(0.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(message.timestamp),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 4),
              if (!message.isRead && !isFromCurrentUser)
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          onTap: () => _openPrivateChat(context, message, currentUserId),
        ),
      ),
    );
  }

  String _getOtherPersonName(Message message, String currentUserId) {
    if (message.senderId == currentUserId) {
      return message.recipientId ?? 'Destinataire';
    } else {
      return message.senderName;
    }
  }

  Color _getAvatarColor(String userId) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
      Colors.purple,
      Colors.orange,
      Colors.teal,
    ];
    final index = userId.hashCode % colors.length;
    return colors[index];
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}j';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min';
    } else {
      return 'Maintenant';
    }
  }

  void _openGroupChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupChatScreen(),
      ),
    );
  }

  void _openPrivateChat(BuildContext context, Message message, String currentUserId) {
    final otherUserId = message.senderId == currentUserId 
        ? message.recipientId 
        : message.senderId;
    
    if (otherUserId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrivateChatScreen(userId: otherUserId),
        ),
      );
    }
  }

  void _startNewChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewChatScreen(),
      ),
    );
  }
}

class MessageSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implémentation de la recherche
    return const Center(child: Text('Fonctionnalité de recherche'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions de recherche
    return const Center(child: Text('Suggestions de recherche'));
  }
}