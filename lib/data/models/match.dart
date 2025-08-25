// lib/data/models/match.dart
class Match {
  final String id;
  final String opponent;
  final DateTime dateTime;
  final String venue;
  final MatchStatus status;
  final MatchResult? result;
  final List<String> selectedPlayers;
  final List<String> startingEleven;
  final List<String> substitutes;
  final String? manOfTheMatch;
  final Map<String, MatchPlayerStats>? playerStats;

  Match({
    required this.id,
    required this.opponent,
    required this.dateTime,
    required this.venue,
    required this.status,
    this.result,
    this.selectedPlayers = const [],
    this.startingEleven = const [],
    this.substitutes = const [],
    this.manOfTheMatch,
    this.playerStats,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'opponent': opponent,
    'dateTime': dateTime.toIso8601String(),
    'venue': venue,
    'status': status.toString(),
    'result': result?.toJson(),
    'selectedPlayers': selectedPlayers,
    'startingEleven': startingEleven,
    'substitutes': substitutes,
    'manOfTheMatch': manOfTheMatch,
    'playerStats': playerStats?.map((k, v) => MapEntry(k, v.toJson())),
  };

  factory Match.fromJson(Map<String, dynamic> json) => Match(
    id: json['id'],
    opponent: json['opponent'],
    dateTime: DateTime.parse(json['dateTime']),
    venue: json['venue'],
    status: MatchStatus.values.firstWhere((e) => e.toString() == json['status']),
    result: json['result'] != null ? MatchResult.fromJson(json['result']) : null,
    selectedPlayers: List<String>.from(json['selectedPlayers'] ?? []),
    startingEleven: List<String>.from(json['startingEleven'] ?? []),
    substitutes: List<String>.from(json['substitutes'] ?? []),
    manOfTheMatch: json['manOfTheMatch'],
    playerStats: json['playerStats'] != null 
      ? Map<String, MatchPlayerStats>.from(
          json['playerStats'].map((k, v) => MapEntry(k, MatchPlayerStats.fromJson(v)))
        ) 
      : null,
  );
}

enum MatchStatus { scheduled, inProgress, completed, cancelled }

class MatchResult {
  final int homeScore;
  final int awayScore;
  final bool isHomeTeam;

  MatchResult({
    required this.homeScore,
    required this.awayScore,
    required this.isHomeTeam,
  });

  String get displayScore => isHomeTeam ? '$homeScore - $awayScore' : '$awayScore - $homeScore';
  
  MatchOutcome get outcome {
    if ((isHomeTeam && homeScore > awayScore) || (!isHomeTeam && awayScore > homeScore)) {
      return MatchOutcome.win;
    } else if (homeScore == awayScore) {
      return MatchOutcome.draw;
    } else {
      return MatchOutcome.loss;
    }
  }

  Map<String, dynamic> toJson() => {
    'homeScore': homeScore,
    'awayScore': awayScore,
    'isHomeTeam': isHomeTeam,
  };

  factory MatchResult.fromJson(Map<String, dynamic> json) => MatchResult(
    homeScore: json['homeScore'],
    awayScore: json['awayScore'],
    isHomeTeam: json['isHomeTeam'],
  );
}

enum MatchOutcome { win, draw, loss }

class MatchPlayerStats {
  final int goals;
  final int assists;
  final int yellowCards;
  final int redCards;
  final double rating;
  final int minutesPlayed;

  MatchPlayerStats({
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
    required this.rating,
    required this.minutesPlayed,
  });

  Map<String, dynamic> toJson() => {
    'goals': goals,
    'assists': assists,
    'yellowCards': yellowCards,
    'redCards': redCards,
    'rating': rating,
    'minutesPlayed': minutesPlayed,
  };

  factory MatchPlayerStats.fromJson(Map<String, dynamic> json) => MatchPlayerStats(
    goals: json['goals'],
    assists: json['assists'],
    yellowCards: json['yellowCards'],
    redCards: json['redCards'],
    rating: json['rating'].toDouble(),
    minutesPlayed: json['minutesPlayed'],
  );
}