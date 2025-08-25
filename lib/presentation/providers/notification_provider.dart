// lib/presentation/providers/notification_provider.dart
import 'package:flutter/foundation.dart';
import 'package:team_manager_app/data/models/notification.dart' as notif;
import 'package:team_manager_app/data/repositories/notification_repository.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationRepository _repository = NotificationRepository();

  List<notif.Notification> _notifications = [];
  bool _isLoading = false;
  String? _error;
  String? _currentUserId;

  // ---------------- Getters ----------------
  List<notif.Notification> get notifications => List.unmodifiable(_notifications);
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  int get totalCount => _notifications.length;
  int get readCount => _notifications.where((n) => n.isRead).length;

  List<notif.Notification> get matchNotifications =>
      _notifications.where((n) => n.type == notif.NotificationType.match).toList();
  List<notif.Notification> get playerNotifications =>
      _notifications.where((n) => n.type == notif.NotificationType.player).toList();
  List<notif.Notification> get teamNotifications =>
      _notifications.where((n) => n.type == notif.NotificationType.team).toList();
  List<notif.Notification> get messageNotifications =>
      _notifications.where((n) => n.type == notif.NotificationType.message).toList();
  List<notif.Notification> get systemNotifications =>
      _notifications.where((n) => n.type == notif.NotificationType.system).toList();

  // ---------------- CRUD ----------------

  Future<void> loadNotifications(String userId) async {
    if (_currentUserId == userId && _notifications.isNotEmpty) return;

    _setLoading(true);
    _setError(null);
    _currentUserId = userId;

    try {
      _notifications = await _repository.getNotifications(userId);
      if (kDebugMode) {
        print("NotificationProvider: Chargé ${_notifications.length} notifications pour $userId");
      }
    } catch (e) {
      _setError("Erreur lors du chargement des notifications: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshNotifications(String userId) async {
    try {
      _notifications = await _repository.getNotifications(userId);
      notifyListeners();
      if (kDebugMode) print("NotificationProvider: Rafraîchi ${_notifications.length} notifications");
    } catch (e) {
      _setError("Erreur lors du rafraîchissement: $e");
    }
  }

  Future<void> addNotification(notif.Notification notification) async {
    try {
      await _repository.addNotification(notification);
      _notifications.insert(0, notification);
      notifyListeners();
      if (kDebugMode) print("NotificationProvider: Nouvelle notification ajoutée");
    } catch (e) {
      _setError("Erreur lors de l'ajout: $e");
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAsRead(notificationId);
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
        notifyListeners();
      }
    } catch (e) {
      _setError("Erreur lors du marquage: $e");
    }
  }

  Future<void> markAllAsRead(String userId) async {
    try {
      await _repository.markAllAsRead(userId);
      _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
      notifyListeners();
    } catch (e) {
      _setError("Erreur lors du marquage global: $e");
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _repository.deleteNotification(notificationId);
      _notifications.removeWhere((n) => n.id == notificationId);
      notifyListeners();
    } catch (e) {
      _setError("Erreur lors de la suppression: $e");
    }
  }

  Future<void> deleteAllNotifications(String userId) async {
    try {
      await _repository.deleteAllNotifications(userId);
      _notifications.clear();
      notifyListeners();
    } catch (e) {
      _setError("Erreur lors de la suppression globale: $e");
    }
  }

  // ---------------- Utilitaires ----------------

  List<notif.Notification> getUnreadNotifications() =>
      _notifications.where((n) => !n.isRead).toList();

  List<notif.Notification> getRecentNotifications() {
    final yesterday = DateTime.now().subtract(const Duration(hours: 24));
    return _notifications.where((n) => n.timestamp.isAfter(yesterday)).toList();
  }

  notif.Notification? getNotificationById(String id) =>
      _notifications.where((n) => n.id == id).firstOrNull;

  List<notif.Notification> getTodayNotifications() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return _notifications.where((n) => n.timestamp.isAfter(startOfDay) && n.timestamp.isBefore(endOfDay)).toList();
  }

  List<notif.Notification> getThisWeekNotifications() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    return _notifications.where((n) => n.timestamp.isAfter(start)).toList();
  }

  // ---------------- Génération de notifications ----------------

  Future<void> createMatchNotification(String userId, String matchId, String opponent, DateTime matchDate) async {
    await _repository.createMatchNotification(userId, matchId, opponent, matchDate);
    await refreshNotifications(userId);
  }

  Future<void> createPlayerNotification(String userId, String playerId, String playerName, String message) async {
    await _repository.createPlayerNotification(userId, playerId, playerName, message);
    await refreshNotifications(userId);
  }

  Future<void> createTeamNotification(String userId, String title, String message) async {
    await _repository.createTeamNotification(userId, title, message);
    await refreshNotifications(userId);
  }

  Future<void> createMessageNotification(String userId, String senderName, String messagePreview) async {
    await _repository.createMessageNotification(userId, senderName, messagePreview);
    await refreshNotifications(userId);
  }

  Future<void> createSystemNotification(String userId, String title, String message) async {
    await _repository.createSystemNotification(userId, title, message);
    await refreshNotifications(userId);
  }

  Future<void> checkPendingNotifications() async {
    await _repository.notifyUpcomingMatches();
    if (_currentUserId != null) await refreshNotifications(_currentUserId!);
  }

  // ---------------- Stats ----------------

  Map<notif.NotificationType, int> getNotificationCountByType() {
    final map = <notif.NotificationType, int>{};
    for (final type in notif.NotificationType.values) {
      map[type] = _notifications.where((n) => n.type == type).length;
    }
    return map;
  }

  Map<notif.NotificationType, int> getUnreadCountByType() {
    final map = <notif.NotificationType, int>{};
    for (final type in notif.NotificationType.values) {
      map[type] = _notifications.where((n) => n.type == type && !n.isRead).length;
    }
    return map;
  }

  // ---------------- Reset ----------------

  void reset() {
    _notifications.clear();
    _isLoading = false;
    _error = null;
    _currentUserId = null;
    notifyListeners();
  }

  // ---------------- Privés ----------------

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  @override
  void dispose() {
    if (kDebugMode) print("NotificationProvider: Provider détruit");
    super.dispose();
  }
}
