
// lib/presentation/providers/message_provider.dart
import 'package:flutter/foundation.dart';
import '../../data/models/message.dart';
import '../../data/repositories/message_repository.dart';

class MessageProvider with ChangeNotifier {
  final MessageRepository _repository = MessageRepository();
  
  List<Message> _groupMessages = [];
  Map<String, List<Message>> _privateChats = {};
  bool _isLoading = false;
  String? _error;

  List<Message> get groupMessages => _groupMessages;
  Map<String, List<Message>> get privateChats => _privateChats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  MessageProvider() {
    loadGroupMessages();
  }

  Future<void> loadGroupMessages() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _groupMessages = await _repository.getGroupMessages();
    } catch (e) {
      _error = e.toString();
      debugPrint('Erreur chargement messages groupe: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadPrivateChat(String userId1, String userId2) async {
    final chatKey = _getChatKey(userId1, userId2);
    
    try {
      _privateChats[chatKey] = await _repository.getPrivateMessages(userId1, userId2);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      debugPrint('Erreur chargement chat privé: $e');
      notifyListeners();
    }
  }

  Future<bool> sendGroupMessage(Message message) async {
    try {
      final success = await _repository.addMessage(message);
      if (success) {
        _groupMessages.add(message);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendPrivateMessage(Message message) async {
    try {
      final success = await _repository.addMessage(message);
      if (success) {
        final chatKey = _getChatKey(message.senderId, message.recipientId!);
        if (_privateChats[chatKey] == null) {
          _privateChats[chatKey] = [];
        }
        _privateChats[chatKey]!.add(message);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  List<Message> getPrivateChat(String userId1, String userId2) {
    final chatKey = _getChatKey(userId1, userId2);
    return _privateChats[chatKey] ?? [];
  }

  Future<List<Message>> getConversationsForUser(String userId) async {
    try {
      return await _repository.getConversationsForUser(userId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  String _getChatKey(String userId1, String userId2) {
    final users = [userId1, userId2]..sort();
    return '${users[0]}_${users[1]}';
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}