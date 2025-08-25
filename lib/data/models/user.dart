// lib/data/models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserType type;
  final String? avatar;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    this.avatar,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'type': type.toString(),
    'avatar': avatar,
    'createdAt': createdAt.toIso8601String(),
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
    type: UserType.values.firstWhere((e) => e.toString() == json['type']),
    avatar: json['avatar'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}

enum UserType { coach, player }