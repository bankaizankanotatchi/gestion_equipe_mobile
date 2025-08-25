// lib/data/models/notification.dart
enum NotificationType {
  match,
  player,
  team,
  system,
  message,
}

class Notification {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? data;
  final String userId; // ID de l'utilisateur associé à la notification

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.userId,
    this.isRead = false,
    this.data,
  });

  Notification copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    DateTime? timestamp,
    String? userId,
    bool? isRead,
    Map<String, dynamic>? data,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
      isRead: isRead ?? this.isRead,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type.index,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'userId': userId,
      'isRead': isRead,
      'data': data,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      type: NotificationType.values[map['type']],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      userId: map['userId'],
      isRead: map['isRead'],
      data: map['data'],
    );
  }

  @override
  String toString() {
    return 'Notification(id: $id, title: $title, type: $type, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Notification && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}