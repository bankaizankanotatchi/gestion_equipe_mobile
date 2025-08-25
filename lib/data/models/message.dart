// lib/data/models/message.dart
class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final String? recipientId; // null pour messages de groupe
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    required this.type,
    this.recipientId,
    this.isRead = false,
  });

  bool get isGroupMessage => recipientId == null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'senderName': senderName,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
    'type': type.toString(),
    'recipientId': recipientId,
    'isRead': isRead,
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json['id'],
    senderId: json['senderId'],
    senderName: json['senderName'],
    content: json['content'],
    timestamp: DateTime.parse(json['timestamp']),
    type: MessageType.values.firstWhere((e) => e.toString() == json['type']),
    recipientId: json['recipientId'],
    isRead: json['isRead'],
  );
}

enum MessageType { text, image, file }