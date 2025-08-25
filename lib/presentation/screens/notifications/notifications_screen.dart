// lib/presentation/screens/notifications/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/notification_provider.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;
import 'package:team_manager_app/presentation/screens/matches/match_detail_screen.dart';
import 'package:team_manager_app/presentation/screens/messages/group_chat_screen.dart';
import 'package:team_manager_app/presentation/screens/players/player_detail_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  notif.NotificationType? _selectedFilter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
      
      if (authProvider.currentUser != null) {
        notificationProvider.loadNotifications(authProvider.currentUser!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Notifications',
          style: AppTextStyles.heading5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              final unreadCount = notificationProvider.unreadCount;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Badge avec le nombre de notifications non lues
                  if (unreadCount > 0)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  // Bouton de filtre
                  IconButton(
                    icon: Icon(
                      _selectedFilter != null ? Icons.filter_alt : Icons.filter_alt_outlined,
                      color: _selectedFilter != null ? AppColors.secondaryLight : Colors.white,
                      
                    ),
                    onPressed: () => _showFilterDialog(context, notificationProvider),
                    tooltip: 'Filtrer',
                  ),
                  // Bouton tout marquer comme lu
                  IconButton(
                    icon: const Icon(Icons.checklist,color: Colors.white,),
                    onPressed: unreadCount > 0 
                        ? () => _markAllAsRead(context, notificationProvider)
                        : null,
                    tooltip: 'Tout marquer comme lu',
                  ),
                  // Menu options
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert,color: Colors.white,),
                    onSelected: (value) => _handleMenuAction(value, notificationProvider),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'refresh',
                        child: Row(
                          children: [
                            Icon(Icons.refresh),
                            SizedBox(width: 8),
                            Text('Actualiser'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'clear_all',
                        child: Row(
                          children: [
                            Icon(Icons.clear_all),
                            SizedBox(width: 8),
                            Text('Supprimer tout'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'settings',
                        child: Row(
                          children: [
                            Icon(Icons.settings),
                            SizedBox(width: 8),
                            Text('Paramètres'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer2<NotificationProvider, AuthProvider>(
        builder: (context, notificationProvider, authProvider, child) {
          if (authProvider.currentUser == null) {
            return _buildErrorState('Utilisateur non connecté');
          }

          if (notificationProvider.isLoading) {
            return _buildLoadingState();
          }

          final notifications = _filterNotifications(notificationProvider.notifications);
          
          if (notifications.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () => notificationProvider.refreshNotifications(authProvider.currentUser!.id),
            child: Column(
              children: [
                // Barre de filtre si active
                if (_selectedFilter != null)
                  _buildFilterChip(),
                // Liste des notifications
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppConstants.paddingSmall),
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(notifications[index], notificationProvider, authProvider.currentUser!.id);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium, vertical: AppConstants.paddingSmall),
      child: Row(
        children: [
          Chip(
            avatar: _buildNotificationIcon(_selectedFilter!, size: 16),
            label: Text(_getFilterName(_selectedFilter!)),
            onDeleted: () {
              setState(() {
                _selectedFilter = null;
              });
            },
            backgroundColor: AppColors.surfaceVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(notif.Notification notification, NotificationProvider provider, String userId) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => _confirmDelete(context, notification),
      background: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppConstants.paddingLarge),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(height: 4),
            Text(
              'Supprimer',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        provider.deleteNotification(notification.id);
        _showSnackBar(context, 'Notification supprimée');
      },
      child: Card(
        color: notification.isRead ? AppColors.surface : AppColors.surfaceVariant,
        elevation: notification.isRead ? AppConstants.elevationSmall : AppConstants.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          side: notification.isRead 
              ? BorderSide.none 
              : BorderSide(color: AppColors.primary.withOpacity(0.2), width: 1),
        ),
        child: InkWell(
          onTap: () => _handleNotificationTap(context, notification, provider, userId),
          onLongPress: () => _showNotificationOptions(context, notification, provider, userId),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationIcon(notification.type),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: AppTextStyles.subtitle1.copyWith(
                                fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
                                color: notification.isRead ? null : AppColors.primary,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(left: 8),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.paddingSmall),
                      Text(
                        notification.message,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.onSurface.withOpacity(0.7),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.paddingSmall),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: AppConstants.iconSizeSmall,
                            color: AppColors.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(notification.timestamp),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.onSurface.withOpacity(0.5),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _getTypeName(notification.type),
                            style: AppTextStyles.caption.copyWith(
                              color: _getTypeColor(notification.type),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(notif.NotificationType type, {double? size}) {
    IconData icon;
    Color color;

    switch (type) {
      case notif.NotificationType.match:
        icon = Icons.sports_soccer;
        color = AppColors.primary;
        break;
      case notif.NotificationType.player:
        icon = Icons.person;
        color = AppColors.secondary;
        break;
      case notif.NotificationType.team:
        icon = Icons.group;
        color = AppColors.info;
        break;
      case notif.NotificationType.system:
        icon = Icons.settings;
        color = AppColors.warning;
        break;
      case notif.NotificationType.message:
        icon = Icons.chat_bubble;
        color = AppColors.accent;
        break;
    }

    return Container(
      padding: EdgeInsets.all(size != null ? 4 : AppConstants.paddingSmall),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon, 
        color: color, 
        size: size ?? AppConstants.iconSizeMedium,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _selectedFilter != null 
                  ? Icons.filter_alt_off 
                  : Icons.notifications_off_outlined,
              size: 80,
              color: AppColors.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            Text(
              _selectedFilter != null 
                  ? 'Aucune notification de ce type'
                  : 'Aucune notification',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              _selectedFilter != null
                  ? 'Essayez un autre filtre ou revenez plus tard'
                  : 'Vous serez informé des nouvelles activités de votre équipe',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
            if (_selectedFilter != null) ...[
              const SizedBox(height: AppConstants.paddingLarge),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedFilter = null;
                  });
                },
                child: const Text('Voir toutes les notifications'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: AppConstants.paddingLarge),
          Text('Chargement des notifications...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error.withOpacity(0.5),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Text(
            'Erreur',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            message,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<notif.Notification> _filterNotifications(List<notif.Notification> notifications) {
    if (_selectedFilter == null) return notifications;
    return notifications.where((n) => n.type == _selectedFilter).toList();
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 7) {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}j';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min';
    } else {
      return 'À l\'instant';
    }
  }

  String _getTypeName(notif.NotificationType type) {
    switch (type) {
      case notif.NotificationType.match:
        return 'Match';
      case notif.NotificationType.player:
        return 'Joueur';
      case notif.NotificationType.team:
        return 'Équipe';
      case notif.NotificationType.system:
        return 'Système';
      case notif.NotificationType.message:
        return 'Message';
    }
  }

  Color _getTypeColor(notif.NotificationType type) {
    switch (type) {
      case notif.NotificationType.match:
        return AppColors.primary;
      case notif.NotificationType.player:
        return AppColors.secondary;
      case notif.NotificationType.team:
        return AppColors.info;
      case notif.NotificationType.system:
        return AppColors.warning;
      case notif.NotificationType.message:
        return AppColors.accent;
    }
  }

  String _getFilterName(notif.NotificationType type) {
    switch (type) {
      case notif.NotificationType.match:
        return 'Matchs';
      case notif.NotificationType.player:
        return 'Joueurs';
      case notif.NotificationType.team:
        return 'Équipe';
      case notif.NotificationType.system:
        return 'Système';
      case notif.NotificationType.message:
        return 'Messages';
    }
  }

  Future<bool> _confirmDelete(BuildContext context, notif.Notification notification) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la notification'),
        content: Text('Êtes-vous sûr de vouloir supprimer "${notification.title}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Supprimer', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    ) ?? false;
  }

  void _showFilterDialog(BuildContext context, NotificationProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrer par type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: const Text('Toutes les notifications'),
              selected: _selectedFilter == null,
              onTap: () {
                setState(() {
                  _selectedFilter = null;
                });
                Navigator.of(context).pop();
              },
            ),
            ...notif.NotificationType.values.map((type) => ListTile(
              leading: _buildNotificationIcon(type, size: 20),
              title: Text(_getFilterName(type)),
              selected: _selectedFilter == type,
              onTap: () {
                setState(() {
                  _selectedFilter = type;
                });
                Navigator.of(context).pop();
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showNotificationOptions(BuildContext context, notif.Notification notification, NotificationProvider provider, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(notification.isRead ? Icons.mark_as_unread : Icons.mark_email_read),
              title: Text(notification.isRead ? 'Marquer comme non lu' : 'Marquer comme lu'),
              onTap: () {
                if (notification.isRead) {
                  // TODO: Implémenter marquer comme non lu
                } else {
                  provider.markAsRead(notification.id);
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.error),
              title: const Text('Supprimer', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.of(context).pop();
                provider.deleteNotification(notification.id);
                _showSnackBar(context, 'Notification supprimée');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleNotificationTap(BuildContext context, notif.Notification notification, NotificationProvider provider, String userId) {
    if (!notification.isRead) {
      provider.markAsRead(notification.id);
    }
    
    // Navigation en fonction du type de notification et des données
    switch (notification.type) {
      case notif.NotificationType.match:
        if (notification.data != null && notification.data!['matchId'] != null) {
          // TODO: Naviguer vers les détails du match
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchDetailScreen(matchId: notification.data!['matchId']),
          ),
        );
        }
        break;
      case notif.NotificationType.player:
        if (notification.data != null && notification.data!['playerId'] != null) {
          // TODO: Naviguer vers les détails du joueur
          // Navigator.of(context).pushNamed('/player-details', arguments: notification.data!['playerId']);
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerDetailScreen(playerId: notification.data!['playerId']),
              ),
            );
        }
        break;
      case notif.NotificationType.message:
        if (notification.data != null && notification.data!['senderId'] != null) {
          // TODO: Naviguer vers les messages
          // Navigator.of(context).pushNamed('/messages', arguments: notification.data!['senderId']);
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GroupChatScreen(),
            ),
          );
        }
        break;
      case notif.NotificationType.team:
      case notif.NotificationType.system:
        _showNotificationDetails(context, notification);
        break;
    }
  }

  void _showNotificationDetails(BuildContext context, notif.Notification notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(notification.message),
              const SizedBox(height: AppConstants.paddingMedium),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: AppConstants.iconSizeSmall,
                    color: AppColors.onSurface.withOpacity(0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Reçu le ${_formatFullDate(notification.timestamp)}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  String _formatFullDate(DateTime timestamp) {
    final months = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    
    return '${timestamp.day} ${months[timestamp.month - 1]} ${timestamp.year} à ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  void _markAllAsRead(BuildContext context, NotificationProvider provider) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.currentUser != null) {
      await provider.markAllAsRead(authProvider.currentUser!.id);
      _showSnackBar(context, 'Toutes les notifications marquées comme lues');
    }
  }

  void _handleMenuAction(String action, NotificationProvider provider) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.currentUser == null) return;

    switch (action) {
      case 'refresh':
        await provider.refreshNotifications(authProvider.currentUser!.id);
        _showSnackBar(context, 'Notifications actualisées');
        break;
      case 'clear_all':
        _confirmClearAll(provider, authProvider.currentUser!.id);
        break;
      case 'settings':
        // TODO: Naviguer vers les paramètres de notifications
        break;
    }
  }

  void _confirmClearAll(NotificationProvider provider, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer toutes les notifications'),
        content: const Text('Cette action est irréversible. Êtes-vous sûr ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              provider.deleteAllNotifications(userId);
              _showSnackBar(context, 'Toutes les notifications supprimées');
            },
            child: const Text('Supprimer', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}