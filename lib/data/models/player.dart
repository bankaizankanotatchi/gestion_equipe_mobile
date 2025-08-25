// lib/data/models/player.dart
import 'package:team_manager_app/data/models/statistics.dart';

class Player {
  final String id;
  final String name;
  final int age;
  final Position position;
  final int jerseyNumber;
  final String? avatar;
  final PlayerStats stats;
  final bool isActive;
  final DateTime joinDate;

  Player({
    required this.id,
    required this.name,
    required this.age,
    required this.position,
    required this.jerseyNumber,
    this.avatar,
    required this.stats,
    this.isActive = true,
    required this.joinDate,
  });

  double get overallRating => stats.calculateOverall();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'position': position.toString(),
    'jerseyNumber': jerseyNumber,
    'avatar': avatar,
    'stats': stats.toJson(),
    'isActive': isActive,
    'joinDate': joinDate.toIso8601String(),
  };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    position: Position.values.firstWhere((e) => e.toString() == json['position']),
    jerseyNumber: json['jerseyNumber'],
    avatar: json['avatar'],
    stats: PlayerStats.fromJson(json['stats']),
    isActive: json['isActive'],
    joinDate: DateTime.parse(json['joinDate']),
  );
}

enum Position {
  goalkeeper,
  defender,
  midfielder,
  forward
}