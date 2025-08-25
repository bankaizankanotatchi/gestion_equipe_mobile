// lib/data/models/statistics.dart
class PlayerStats {
  final int pace;      // Vitesse
  final int shooting;  // Tir
  final int passing;   // Passes
  final int dribbling; // Dribble
  final int defending; // Défense
  final int physical;  // Physique

  PlayerStats({
    required this.pace,
    required this.shooting,
    required this.passing,
    required this.dribbling,
    required this.defending,
    required this.physical,
  });

  double calculateOverall() {
    return (pace + shooting + passing + dribbling + defending + physical) / 6.0;
  }

  Map<String, dynamic> toJson() => {
    'pace': pace,
    'shooting': shooting,
    'passing': passing,
    'dribbling': dribbling,
    'defending': defending,
    'physical': physical,
  };

  factory PlayerStats.fromJson(Map<String, dynamic> json) => PlayerStats(
    pace: json['pace'],
    shooting: json['shooting'],
    passing: json['passing'],
    dribbling: json['dribbling'],
    defending: json['defending'],
    physical: json['physical'],
  );
}