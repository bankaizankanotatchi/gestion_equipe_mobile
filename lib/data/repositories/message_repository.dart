
// lib/data/repositories/message_repository.dart
import '../models/message.dart';
import '../database/mock_database.dart';

class MessageRepository {
  final MockDatabase _database = MockDatabase.instance;

  Future<List<Message>> getAllMessages() async {
    return _database.messages;
  }

  Future<List<Message>> getGroupMessages() async {
    return _database.getGroupMessages();
  }

  Future<List<Message>> getPrivateMessages(String userId1, String userId2) async {
    return _database.getPrivateMessages(userId1, userId2);
  }

  Future<List<Message>> getConversationsForUser(String userId) async {
    return _database.getConversationsForUser(userId);
  }

  Future<bool> addMessage(Message message) async {
    try {
      _database.addMessage(message);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> markMessageAsRead(String messageId) async {
    try {
      _database.markMessageAsRead(messageId);
      return true;
    } catch (e) {
      return false;
    }
  }
}