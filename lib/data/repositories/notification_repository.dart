// lib/data/repositories/notification_repository.dart
import 'package:team_manager_app/data/models/user.dart';

import '../models/notification.dart';
import '../database/mock_database.dart';

class NotificationRepository {
  final MockDatabase _database = MockDatabase.instance;

  // Récupérer toutes les notifications d'un utilisateur
  Future<List<Notification>> getNotifications(String userId) async {
    final notifications = _database.getNotificationsForUser(userId);
    // Tri décroissant par date
    notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return notifications;
  }

  // Ajouter une notification
  Future<bool> addNotification(Notification notification) async {
    try {
      _database.addNotification(notification);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Marquer une notification comme lue
  Future<bool> markAsRead(String notificationId) async {
    try {
      _database.markNotificationAsRead(notificationId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Marquer toutes les notifications comme lues
  Future<bool> markAllAsRead(String userId) async {
    try {
      _database.markAllNotificationsAsRead(userId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Supprimer une notification
  Future<bool> deleteNotification(String notificationId) async {
    try {
      _database.deleteNotification(notificationId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Supprimer toutes les notifications d'un utilisateur
  Future<bool> deleteAllNotifications(String userId) async {
    try {
      _database.deleteAllNotifications(userId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Obtenir le nombre de notifications non lues
  Future<int> getUnreadCount(String userId) async {
    final notifications = _database.getNotificationsForUser(userId);
    return notifications.where((n) => !n.isRead).length;
  }

  // Obtenir les notifications par type
  Future<List<Notification>> getNotificationsByType(String userId, NotificationType type) async {
    final notifications = _database.getNotificationsForUser(userId);
    return notifications.where((n) => n.type == type).toList();
  }

  // Créer une notification pour un match
  Future<bool> createMatchNotification(String userId, String matchId, String opponent, DateTime matchDate) async {
    final notification = Notification(
      id: 'match_${matchId}_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Prochain match',
      message: 'Match contre $opponent le ${_formatDate(matchDate)}',
      type: NotificationType.match,
      timestamp: DateTime.now(),
      userId: userId,
      data: {
        'matchId': matchId,
        'opponent': opponent,
        'date': matchDate.toIso8601String(),
      },
    );
    return await addNotification(notification);
  }

  // Créer une notification joueur
  Future<bool> createPlayerNotification(String userId, String playerId, String playerName, String message) async {
    final notification = Notification(
      id: 'player_${playerId}_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Information joueur',
      message: '$playerName: $message',
      type: NotificationType.player,
      timestamp: DateTime.now(),
      userId: userId,
      data: {'playerId': playerId, 'playerName': playerName},
    );
    return await addNotification(notification);
  }

  // Créer une notification d'équipe
  Future<bool> createTeamNotification(String userId, String title, String message) async {
    final notification = Notification(
      id: 'team_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      message: message,
      type: NotificationType.team,
      timestamp: DateTime.now(),
      userId: userId,
    );
    return await addNotification(notification);
  }

  // Créer une notification message
  Future<bool> createMessageNotification(String userId, String senderName, String messagePreview) async {
    final notification = Notification(
      id: 'message_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Nouveau message',
      message: '$senderName: $messagePreview',
      type: NotificationType.message,
      timestamp: DateTime.now(),
      userId: userId,
      data: {'senderName': senderName},
    );
    return await addNotification(notification);
  }

  // Créer une notification système
  Future<bool> createSystemNotification(String userId, String title, String message) async {
    final notification = Notification(
      id: 'system_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      message: message,
      type: NotificationType.system,
      timestamp: DateTime.now(),
      userId: userId,
    );
    return await addNotification(notification);
  }

  // Notifier les matchs à venir (24h avant)
  Future<void> notifyUpcomingMatches() async {
    final matches = _database.getUpcomingMatches();
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    for (final match in matches) {
      if (match.dateTime.day == tomorrow.day &&
          match.dateTime.month == tomorrow.month &&
          match.dateTime.year == tomorrow.year) {
        // Joueurs sélectionnés
        if (match.selectedPlayers != null) {
          for (final playerId in match.selectedPlayers!) {
            await createMatchNotification(playerId, match.id, match.opponent, match.dateTime);
          }
        }
        // Coachs
        final coaches = _database.getUsersByType(UserType.coach);
        for (final coach in coaches) {
          await createMatchNotification(coach.id, match.id, match.opponent, match.dateTime);
        }
      }
    }
  }

  // Formatage des dates
  String _formatDate(DateTime date) {
    final months = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
