// lib/data/database/mock_database.dart
import 'package:team_manager_app/data/models/notification.dart';

import '../models/user.dart';
import '../models/player.dart';
import '../models/match.dart';
import '../models/statistics.dart';
import '../models/message.dart';

class MockDatabase {
  static MockDatabase? _instance;
  static MockDatabase get instance => _instance ??= MockDatabase._();
  MockDatabase._();

  // Données fictives
  final List<User> _users = [
    // Entraîneurs (gardés)
    User(
      id: 'coach1',
      name: 'Jean Dubois',
      email: 'jean.dubois@team.com',
      password: 'coach123',
      type: UserType.coach,
      avatar: 'assets/avatars/coach1.jpg',
      createdAt: DateTime(2024, 1, 15),
    ),
    User(
      id: 'coach2',
      name: 'Marie Martin',
      email: 'marie.martin@team.com',
      password: 'coach456',
      type: UserType.coach,
      avatar: 'assets/avatars/coach1.jpg',
      createdAt: DateTime(2024, 1, 16),
    ),
    // Gardiens (gardés)
    User(
      id: 'player1',
      name: 'Antoine Leroy',
      email: 'antoine.leroy@team.com',
      password: 'player123',
      type: UserType.player,
      avatar: 'assets/avatars/player1.jpg',
      createdAt: DateTime(2024, 2, 1),
    ),
    User(
      id: 'player12',
      name: 'Hugo Martinez',
      email: 'hugo.martinez@team.com',
      password: 'player109',
      type: UserType.player,
      avatar: 'assets/avatars/player1.jpg',
      createdAt: DateTime(2024, 2, 12),
    ),
    // Nouveaux joueurs
    User(
      id: 'player2',
      name: 'Kameni Ulrich',
      email: 'ulrich.kameni@team.com',
      password: 'player456',
      type: UserType.player,
      avatar: 'assets/avatars/coach1.jpg',
      createdAt: DateTime(2024, 2, 2),
    ),
    User(
      id: 'player3',
      name: 'Pouani Douglas',
      email: 'douglas.pouani@team.com',
      password: 'player789',
      type: UserType.player,
      avatar: 'assets/avatars/player3.jpeg',
      createdAt: DateTime(2024, 2, 3),
    ),
    User(
      id: 'player4',
      name: 'Djam Alexandre',
      email: 'alexandre.djam@team.com',
      password: 'player101',
      type: UserType.player,
      avatar: 'assets/avatars/player4.jpeg',
      createdAt: DateTime(2024, 2, 4),
    ),
    User(
      id: 'player5',
      name: 'Nwaha Georges',
      email: 'georges.nwaha@team.com',
      password: 'player102',
      type: UserType.player,
      avatar: 'assets/avatars/player5.jpeg',
      createdAt: DateTime(2024, 2, 5),
    ),
    User(
      id: 'player6',
      name: 'Ako Michel',
      email: 'michel.ako@team.com',
      password: 'player103',
      type: UserType.player,
      avatar: 'assets/avatars/player6.jpeg',
      createdAt: DateTime(2024, 2, 6),
    ),
    User(
      id: 'player7',
      name: 'Ngwe Samuel Hervé',
      email: 'samuel.ngwe@team.com',
      password: 'player104',
      type: UserType.player,
      avatar: 'assets/avatars/player1.jpg',
      createdAt: DateTime(2024, 2, 7),
    ),
    User(
      id: 'player8',
      name: 'Ndoky Jaco',
      email: 'jaco.ndoky@team.com',
      password: 'player105',
      type: UserType.player,
      avatar: 'assets/avatars/player8.jpeg',
      createdAt: DateTime(2024, 2, 8),
    ),
    User(
      id: 'player9',
      name: 'Ewane Serge',
      email: 'serge.ewane@team.com',
      password: 'player106',
      type: UserType.player,
      avatar: 'assets/avatars/player9.jpeg',
      createdAt: DateTime(2024, 2, 9),
    ),
    User(
      id: 'player10',
      name: 'Ndoumin Yannick',
      email: 'yannick.ndoumin@team.com',
      password: 'player107',
      type: UserType.player,
      avatar: 'assets/avatars/player10.jpeg',
      createdAt: DateTime(2024, 2, 10),
    ),
    User(
      id: 'player11',
      name: 'Dibongue Paceli',
      email: 'paceli.dibongue@team.com',
      password: 'player108',
      type: UserType.player,
      avatar: 'assets/avatars/player1.jpg',
      createdAt: DateTime(2024, 2, 11),
    ),
    User(
      id: 'player13',
      name: 'Youpou Christian',
      email: 'christian.youpou@team.com',
      password: 'player110',
      type: UserType.player,
      avatar: 'assets/avatars/player13.jpeg',
      createdAt: DateTime(2024, 2, 13),
    ),
    User(
      id: 'player14',
      name: 'Saagu Wilson',
      email: 'wilson.saagu@team.com',
      password: 'player111',
      type: UserType.player,
      avatar: 'assets/avatars/player14.jpeg',
      createdAt: DateTime(2024, 2, 14),
    ),
    User(
      id: 'player15',
      name: 'Seton Arthur',
      email: 'arthur.seton@team.com',
      password: 'player112',
      type: UserType.player,
      avatar: 'assets/avatars/player15.jpeg',
      createdAt: DateTime(2024, 2, 15),
    ),
    User(
      id: 'player16',
      name: 'Melingui Prince',
      email: 'prince.melingui@team.com',
      password: 'player113',
      type: UserType.player,
      avatar: 'assets/avatars/player1.jpg',
      createdAt: DateTime(2024, 2, 16),
    ),
    User(
      id: 'player17',
      name: 'Jocky Stéphane',
      email: 'stephane.jocky@team.com',
      password: 'player114',
      type: UserType.player,
      avatar: 'assets/avatars/player1.jpg',
      createdAt: DateTime(2024, 2, 17),
    ),
    User(
      id: 'player18',
      name: 'Tabi Roger',
      email: 'roger.tabi@team.com',
      password: 'player115',
      type: UserType.player,
      avatar: 'assets/avatars/player18.jpeg',
      createdAt: DateTime(2024, 2, 18),
    ),
    User(
      id: 'player19',
      name: 'Tabi Aldof',
      email: 'aldof.tabi@team.com',
      password: 'player116',
      type: UserType.player,
      avatar: 'assets/avatars/player19.jpeg',
      createdAt: DateTime(2024, 2, 19),
    ),
    User(
      id: 'player20',
      name: 'Tchognia Arthur',
      email: 'arthur.tchognia@team.com',
      password: 'player117',
      type: UserType.player,
      avatar: 'assets/avatars/player1.jpg',
      createdAt: DateTime(2024, 2, 20),
    ),
    User(
      id: 'player21',
      name: 'Bille Yvan',
      email: 'yvan.bille@team.com',
      password: 'player118',
      type: UserType.player,
      avatar: 'assets/avatars/player21.jpeg',
      createdAt: DateTime(2024, 2, 21),
    ),
    User(
      id: 'player22',
      name: 'Tabela Patrice',
      email: 'patrice.tabela@team.com',
      password: 'player119',
      type: UserType.player,
      avatar: 'assets/avatars/player22.jpeg',
      createdAt: DateTime(2024, 2, 22),
    ),
  ];

  final List<Player> _players = [
    // Gardiens (gardés)
    Player(
      id: 'player1',
      name: 'Antoine Leroy',
      age: 25,
      position: Position.goalkeeper,
      jerseyNumber: 1,
      avatar: 'assets/avatars/player1.png',
      stats: PlayerStats(
        pace: 45,
        shooting: 15,
        passing: 65,
        dribbling: 25,
        defending: 85,
        physical: 80,
      ),
      joinDate: DateTime(2024, 2, 1),
    ),
    Player(
      id: 'player12',
      name: 'Hugo Martinez',
      age: 19,
      position: Position.goalkeeper,
      jerseyNumber: 12,
      avatar: 'assets/avatars/player1.jpg',
      stats: PlayerStats(
        pace: 40,
        shooting: 12,
        passing: 60,
        dribbling: 20,
        defending: 78,
        physical: 75,
      ),
      joinDate: DateTime(2024, 2, 12),
    ),
    // Nouveaux joueurs
    Player(
      id: 'player2',
      name: 'Kameni Ulrich',
      age: 24,
      position: Position.midfielder,
      jerseyNumber: 14,
      avatar: 'assets/avatars/player2.jpeg',
      stats: PlayerStats(
        pace: 82,
        shooting: 75,
        passing: 88,
        dribbling: 85,
        defending: 70,
        physical: 78,
      ),
      joinDate: DateTime(2024, 2, 2),
    ),
    Player(
      id: 'player3',
      name: 'Pouani Douglas',
      age: 26,
      position: Position.midfielder,
      jerseyNumber: 6,
      avatar: 'assets/avatars/player3.jpeg',
      stats: PlayerStats(
        pace: 78,
        shooting: 70,
        passing: 85,
        dribbling: 80,
        defending: 75,
        physical: 82,
      ),
      joinDate: DateTime(2024, 2, 3),
    ),
    Player(
      id: 'player4',
      name: 'Djam Alexandre',
      age: 25,
      position: Position.midfielder,
      jerseyNumber: 23,
      avatar: 'assets/avatars/player4.jpeg',
      stats: PlayerStats(
        pace: 80,
        shooting: 72,
        passing: 84,
        dribbling: 78,
        defending: 68,
        physical: 76,
      ),
      joinDate: DateTime(2024, 2, 4),
    ),
    Player(
      id: 'player5',
      name: 'Nwaha Georges',
      age: 23,
      position: Position.forward,
      jerseyNumber: 7,
      avatar: 'assets/avatars/player5.jpeg',
      stats: PlayerStats(
        pace: 86,
        shooting: 88,
        passing: 75,
        dribbling: 82,
        defending: 40,
        physical: 80,
      ),
      joinDate: DateTime(2024, 2, 5),
    ),
    Player(
      id: 'player6',
      name: 'Ako Michel',
      age: 27,
      position: Position.defender,
      jerseyNumber: 11,
      avatar: 'assets/avatars/player6.jpeg',
      stats: PlayerStats(
        pace: 85,
        shooting: 65,
        passing: 75,
        dribbling: 70,
        defending: 82,
        physical: 80,
      ),
      joinDate: DateTime(2024, 2, 6),
    ),
    Player(
      id: 'player7',
      name: 'Ngwe Samuel Hervé',
      age: 22,
      position: Position.defender,
      jerseyNumber: 25,
      avatar: 'assets/avatars/player1.jpg',
      stats: PlayerStats(
        pace: 79,
        shooting: 74,
        passing: 82,
        dribbling: 78,
        defending: 72,
        physical: 77,
      ),
      joinDate: DateTime(2024, 2, 7),
    ),
    Player(
      id: 'player8',
      name: 'Ndoky Jaco',
      age: 28,
      position: Position.midfielder,
      jerseyNumber: 10,
      avatar: 'assets/avatars/player8.jpeg',
      stats: PlayerStats(
        pace: 76,
        shooting: 78,
        passing: 87,
        dribbling: 83,
        defending: 70,
        physical: 79,
      ),
      joinDate: DateTime(2024, 2, 8),
    ),
    Player(
      id: 'player9',
      name: 'Ewane Serge',
      age: 26,
      position: Position.defender,
      jerseyNumber: 15,
      avatar: 'assets/avatars/player9.jpeg',
      stats: PlayerStats(
        pace: 77,
        shooting: 65,
        passing: 72,
        dribbling: 68,
        defending: 85,
        physical: 82,
      ),
      joinDate: DateTime(2024, 2, 9),
    ),
    Player(
      id: 'player10',
      name: 'Ndoumin Yannick',
      age: 24,
      position: Position.forward,
      jerseyNumber: 24,
      avatar: 'assets/avatars/player10.jpeg',
      stats: PlayerStats(
        pace: 81,
        shooting: 76,
        passing: 84,
        dribbling: 82,
        defending: 68,
        physical: 75,
      ),
      joinDate: DateTime(2024, 2, 10),
    ),
    Player(
      id: 'player11',
      name: 'Dibongue Paceli',
      age: 25,
      position: Position.defender,
      jerseyNumber: 13,
      avatar: 'assets/avatars/player1.jpg',
      stats: PlayerStats(
        pace: 80,
        shooting: 75,
        passing: 83,
        dribbling: 79,
        defending: 70,
        physical: 78,
      ),
      joinDate: DateTime(2024, 2, 11),
    ),
    Player(
      id: 'player13',
      name: 'Youpou Christian',
      age: 22,
      position: Position.forward,
      jerseyNumber: 27,
      avatar: 'assets/avatars/player13.jpeg',
      stats: PlayerStats(
        pace: 88,
        shooting: 86,
        passing: 78,
        dribbling: 84,
        defending: 38,
        physical: 82,
      ),
      joinDate: DateTime(2024, 2, 13),
    ),
    Player(
      id: 'player14',
      name: 'Saagu Wilson',
      age: 23,
      position: Position.defender,
      jerseyNumber: 0,
      avatar: 'assets/avatars/player14.jpeg',
      stats: PlayerStats(
        pace: 79,
        shooting: 68,
        passing: 76,
        dribbling: 72,
        defending: 84,
        physical: 81,
      ),
      joinDate: DateTime(2024, 2, 14),
    ),
    Player(
      id: 'player15',
      name: 'Seton Arthur',
      age: 26,
      position: Position.defender,
      jerseyNumber: 8,
      avatar: 'assets/avatars/player15.jpeg',
      stats: PlayerStats(
        pace: 78,
        shooting: 65,
        passing: 74,
        dribbling: 70,
        defending: 83,
        physical: 80,
      ),
      joinDate: DateTime(2024, 2, 15),
    ),
    Player(
      id: 'player16',
      name: 'Melingui Prince',
      age: 21,
      position: Position.forward,
      jerseyNumber: 5,
      avatar: 'assets/avatars/player16.jpeg',
      stats: PlayerStats(
        pace: 84,
        shooting: 85,
        passing: 76,
        dribbling: 82,
        defending: 42,
        physical: 79,
      ),
      joinDate: DateTime(2024, 2, 16),
    ),
    Player(
      id: 'player17',
      name: 'Jocky Stéphane',
      age: 27,
      position: Position.defender,
      jerseyNumber: 16,
      avatar: 'assets/avatars/player17.jpeg',
      stats: PlayerStats(
        pace: 76,
        shooting: 62,
        passing: 70,
        dribbling: 68,
        defending: 86,
        physical: 83,
      ),
      joinDate: DateTime(2024, 2, 17),
    ),
    Player(
      id: 'player18',
      name: 'Tabi Roger',
      age: 24,
      position: Position.forward,
      jerseyNumber: 9,
      avatar: 'assets/avatars/player18.jpeg',
      stats: PlayerStats(
        pace: 85,
        shooting: 87,
        passing: 77,
        dribbling: 83,
        defending: 40,
        physical: 81,
      ),
      joinDate: DateTime(2024, 2, 18),
    ),
    Player(
      id: 'player19',
      name: 'Tabi Aldolph',
      age: 25,
      position: Position.defender,
      jerseyNumber: 66,
      avatar: 'assets/avatars/player19.jpeg',
      stats: PlayerStats(
        pace: 77,
        shooting: 68,
        passing: 75,
        dribbling: 71,
        defending: 84,
        physical: 82,
      ),
      joinDate: DateTime(2024, 2, 19),
    ),
    Player(
      id: 'player20',
      name: 'Tchognia Arthur',
      age: 29,
      position: Position.defender,
      jerseyNumber: 7,
      avatar: 'assets/avatars/player20.jpeg',
      stats: PlayerStats(
        pace: 82,
        shooting: 72,
        passing: 80,
        dribbling: 78,
        defending: 87,
        physical: 85,
      ),
      joinDate: DateTime(2024, 2, 20),
    ),
    Player(
      id: 'player21',
      name: 'Bille Yvan',
      age: 23,
      position: Position.defender,
      jerseyNumber: 22,
      avatar: 'assets/avatars/player21.jpeg',
      stats: PlayerStats(
        pace: 80,
        shooting: 77,
        passing: 85,
        dribbling: 82,
        defending: 72,
        physical: 78,
      ),
      joinDate: DateTime(2024, 2, 21),
    ),
    Player(
      id: 'player22',
      name: 'Tabela Patrice',
      age: 24,
      position: Position.midfielder,
      jerseyNumber: 19,
      avatar: 'assets/avatars/player22.jpeg',
      stats: PlayerStats(
        pace: 83,
        shooting: 79,
        passing: 86,
        dribbling: 84,
        defending: 74,
        physical: 80,
      ),
      joinDate: DateTime(2024, 2, 22),
    ),
    Player(
      id: 'player23',
      name: 'Hervé Junior',
      age: 24,
      position: Position.midfielder,
      jerseyNumber: 19,
      avatar: 'assets/avatars/player23.jpeg',
      stats: PlayerStats(
        pace: 83,
        shooting: 79,
        passing: 86,
        dribbling: 84,
        defending: 74,
        physical: 50,
      ),
      joinDate: DateTime(2024, 2, 22),
    ),
  ];
  
  final List<Match> _matches = [
    // Matchs passés
    Match(
      id: 'match1',
      opponent: 'FC Lions',
      dateTime: DateTime(2024, 7, 15, 15, 0),
      venue: 'Stade Municipal',
      status: MatchStatus.completed,
      result: MatchResult(homeScore: 2, awayScore: 1, isHomeTeam: true),
      selectedPlayers: ['player1', 'player2', 'player3', 'player4', 'player5', 'player6', 'player7', 'player8', 'player9', 'player10', 'player11', 'player12', 'player13', 'player14'],
      startingEleven: ['player1', 'player2', 'player3', 'player4', 'player5', 'player6', 'player7', 'player8', 'player9', 'player10', 'player11'],
      substitutes: ['player12', 'player13', 'player14'],
      manOfTheMatch: 'Nwaha Georges',
      playerStats: {
        'player5': MatchPlayerStats(goals: 2, assists: 0, yellowCards: 0, redCards: 0, rating: 8.5, minutesPlayed: 90),
        'player8': MatchPlayerStats(goals: 0, assists: 1, yellowCards: 1, redCards: 0, rating: 7.2, minutesPlayed: 90),
        'player3': MatchPlayerStats(goals: 0, assists: 1, yellowCards: 0, redCards: 0, rating: 7.8, minutesPlayed: 90),
      },
    ),
    Match(
      id: 'match2',
      opponent: 'AS Eagles',
      dateTime: DateTime(2024, 7, 22, 16, 30),
      venue: 'Stade des Aigles',
      status: MatchStatus.completed,
      result: MatchResult(homeScore: 1, awayScore: 1, isHomeTeam: false),
      selectedPlayers: ['player1', 'player2', 'player3', 'player4', 'player5', 'player6', 'player7', 'player8', 'player9', 'player10', 'player11', 'player12', 'player13', 'player15'],
      startingEleven: ['player1', 'player2', 'player3', 'player4', 'player5', 'player6', 'player7', 'player8', 'player9', 'player10', 'player11'],
      substitutes: ['player12', 'player13', 'player15'],
      manOfTheMatch: 'Youpou Christian',
      playerStats: {
        'player13': MatchPlayerStats(goals: 1, assists: 0, yellowCards: 0, redCards: 0, rating: 8.0, minutesPlayed: 90),
        'player7': MatchPlayerStats(goals: 0, assists: 1, yellowCards: 0, redCards: 0, rating: 7.5, minutesPlayed: 90),
      },
    ),
    // Matchs programmés
    Match(
      id: 'match3',
      opponent: 'SC Wolves',
      dateTime: DateTime(2024, 8, 25, 15, 0),
      venue: 'Stade Municipal',
      status: MatchStatus.scheduled,
      selectedPlayers: ['player1', 'player2', 'player3', 'player4', 'player5', 'player6', 'player7', 'player8', 'player9', 'player10', 'player11', 'player12', 'player13', 'player14'],
      startingEleven: ['player1', 'player2', 'player3', 'player4', 'player5', 'player6', 'player7', 'player8', 'player9', 'player10', 'player11'],
      substitutes: ['player12', 'player13', 'player14'],
    ),
    Match(
      id: 'match4',
      opponent: 'Racing Tigers',
      dateTime: DateTime(2024, 9, 1, 14, 0),
      venue: 'Stade des Tigres',
      status: MatchStatus.scheduled,
    ),
    Match(
      id: 'match5',
      opponent: 'United Bears',
      dateTime: DateTime(2024, 9, 8, 16, 0),
      venue: 'Stade Municipal',
      status: MatchStatus.scheduled,
    ),
  ];

  final List<Message> _messages = [
    // Messages de groupe
    Message(
      id: 'msg1',
      senderId: 'coach1',
      senderName: 'Jean Dubois',
      content: 'Bonjour à tous ! Entraînement demain à 18h00. Soyez à l\'heure !',
      timestamp: DateTime(2024, 8, 20, 14, 30),
      type: MessageType.text,
    ),
    Message(
      id: 'msg2',
      senderId: 'player3',
      senderName: 'Pouani Douglas',
      content: 'Reçu coach ! On sera tous là 💪',
      timestamp: DateTime(2024, 8, 20, 14, 35),
      type: MessageType.text,
    ),
    Message(
      id: 'msg3',
      senderId: 'coach2',
      senderName: 'Marie Martin',
      content: 'N\'oubliez pas vos crampons et vos protège-tibias !',
      timestamp: DateTime(2024, 8, 20, 14, 40),
      type: MessageType.text,
    ),
    Message(
      id: 'msg4',
      senderId: 'player5',
      senderName: 'Nwaha Georges',
      content: 'Coach, est-ce qu\'on travaille les corners demain ?',
      timestamp: DateTime(2024, 8, 20, 15, 15),
      type: MessageType.text,
    ),
    Message(
      id: 'msg5',
      senderId: 'coach1',
      senderName: 'Jean Dubois',
      content: 'Oui Georges, on va travailler les phases arrêtées pendant 30 minutes',
      timestamp: DateTime(2024, 8, 20, 15, 20),
      type: MessageType.text,
    ),
    // Messages privés
    Message(
      id: 'private1',
      senderId: 'coach1',
      senderName: 'Jean Dubois',
      content: 'Salut Antoine, j\'aimerais te parler de ta position sur les corners',
      timestamp: DateTime(2024, 8, 19, 10, 30),
      type: MessageType.text,
      recipientId: 'player1',
    ),
    Message(
      id: 'private2',
      senderId: 'player1',
      senderName: 'Antoine Leroy',
      content: 'Bonjour coach ! Oui, je vous écoute',
      timestamp: DateTime(2024, 8, 19, 10, 35),
      type: MessageType.text,
      recipientId: 'coach1',
    ),
    Message(
      id: 'private3',
      senderId: 'coach1',
      senderName: 'Jean Dubois',
      content: 'Tu restes trop sur ta ligne, essaie de sortir un peu plus pour couper les centres',
      timestamp: DateTime(2024, 8, 19, 10, 40),
      type: MessageType.text,
      recipientId: 'player1',
    ),
    Message(
      id: 'private4',
      senderId: 'coach2',
      senderName: 'Marie Martin',
      content: 'Salut Georges ! Félicitations pour ton match de dimanche, 2 buts magnifiques !',
      timestamp: DateTime(2024, 8, 16, 9, 15),
      type: MessageType.text,
      recipientId: 'player5',
    ),
    Message(
      id: 'private5',
      senderId: 'player5',
      senderName: 'Nwaha Georges',
      content: 'Merci coach Marie ! J\'ai travaillé ma finition comme vous me l\'aviez conseillé',
      timestamp: DateTime(2024, 8, 16, 9, 20),
      type: MessageType.text,
      recipientId: 'coach2',
    ),
  ];

  final List<Notification> _notifications = [
    // Notifications pour les joueurs
    Notification(
      id: 'notif1',
      title: 'Prochain match',
      message: 'Match contre SC Wolves le 25 août 2024 à 15:00',
      type: NotificationType.match,
      timestamp: DateTime(2024, 8, 20, 9, 0),
      userId: 'coach1',
      data: {'matchId': 'match3', 'opponent': 'SC Wolves'},
    ),
    Notification(
      id: 'notif2',
      title: 'Entraînement',
      message: 'Entraînement programmé demain à 18h00',
      type: NotificationType.team,
      timestamp: DateTime(2024, 8, 20, 14, 0),
      userId: 'player1',
      isRead: true,
    ),
    Notification(
      id: 'notif3',
      title: 'Nouveau message',
      message: 'Jean Dubois: Bonjour à tous ! Entraînement demain...',
      type: NotificationType.message,
      timestamp: DateTime(2024, 8, 20, 14, 30),
      userId: 'player1',
      data: {'senderId': 'coach1', 'senderName': 'Jean Dubois'},
    ),
    Notification(
      id: 'notif4',
      title: 'Mise à jour du profil',
      message: 'Votre profil a été mis à jour avec succès',
      type: NotificationType.system,
      timestamp: DateTime(2024, 8, 19, 16, 20),
      userId: 'coach1',
      isRead: true,
    ),
    Notification(
      id: 'notif5',
      title: 'Performance du match',
      message: 'Félicitations ! Vous avez été élu homme du match contre FC Lions',
      type: NotificationType.player,
      timestamp: DateTime(2024, 7, 15, 17, 30),
      userId: 'player5',
      isRead: true,
      data: {'matchId': 'match1', 'performance': 'man_of_match'},
    ),
  ];

  // Méthodes d'accès aux données

  // Méthodes pour les notifications
  List<Notification> get notifications => List.unmodifiable(_notifications);

  List<Notification> getNotificationsForUser(String userId, {NotificationType? type}) {
    // Dans une vraie implémentation, on filtrerait par userId
    // Ici on retourne toutes les notifications pour la démo
    List<Notification> userNotifications = List.from(_notifications);
    
    if (type != null) {
      userNotifications = userNotifications.where((n) => n.type == type).toList();
    }
    
    userNotifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return userNotifications;
  }

  Notification? getNotificationById(String id) {
    try {
      return _notifications.firstWhere((notification) => notification.id == id);
    } catch (e) {
      return null;
    }
  }

  void addNotification(Notification notification) {
    _notifications.insert(0, notification);
    
    // Limiter à 100 notifications max
    if (_notifications.length > 100) {
      _notifications.removeRange(100, _notifications.length);
    }
  }

  void markNotificationAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  void markAllNotificationsAsRead(String userId) {
    // Dans une vraie implémentation, on filtrerait par userId
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  void deleteNotification(String notificationId) {
    _notifications.removeWhere((notification) => notification.id == notificationId);
  }

  void deleteAllNotifications(String userId) {
    // Dans une vraie implémentation, on filtrerait par userId
    _notifications.clear();
  }

  int getUnreadNotificationsCount(String userId) {
    // Dans une vraie implémentation, on filtrerait par userId
    return _notifications.where((n) => !n.isRead).length;
  }

  List<Notification> getNotificationsByType(String userId, NotificationType type) {
    return getNotificationsForUser(userId, type: type);
  }

  // Méthodes utilitaires pour créer des notifications automatiques
  void createMatchNotification(String userId, String matchId, String opponent, DateTime matchDate) {
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
        'userId': userId,
      },
    );
    
    addNotification(notification);
  }

  void createPlayerUpdateNotification(String userId, String playerName, String updateMessage) {
    final notification = Notification(
      id: 'player_${userId}_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Mise à jour joueur',
      message: '$playerName: $updateMessage',
      type: NotificationType.player,
      timestamp: DateTime.now(),
      userId: userId,
      data: {
        'playerId': userId,
        'playerName': playerName,
      },
    );
    
    addNotification(notification);
  }

  void createTeamNotification(String title, String message) {
    final notification = Notification(
      id: 'team_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      message: message,
      type: NotificationType.team,
      timestamp: DateTime.now(),
      userId: 'all', // Notification pour toute l'équipe
    );
    
    addNotification(notification);
  }

  void createMessageNotification(String userId, String senderName, String messagePreview) {
    final notification = Notification(
      id: 'message_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Nouveau message',
      message: '$senderName: $messagePreview',
      type: NotificationType.message,
      timestamp: DateTime.now(),
      userId: userId,
      data: {
        'senderName': senderName,
        'userId': userId,
      },
    );
    
    addNotification(notification);
  }

  // Méthode utilitaire pour formater les dates
  String _formatDate(DateTime date) {
    final months = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    
    return '${date.day} ${months[date.month - 1]} ${date.year} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
  
  // Users
  List<User> get users => List.unmodifiable(_users);
  
  User? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  User? getUserByEmail(String email) {
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  List<User> getUsersByType(UserType type) {
    return _users.where((user) => user.type == type).toList();
  }

  // Players
  List<Player> get players => List.unmodifiable(_players);
  
  Player? getPlayerById(String id) {
    try {
      return _players.firstWhere((player) => player.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Player> getPlayersByPosition(Position position) {
    return _players.where((player) => player.position == position).toList();
  }

  List<Player> getActivePlayersSortedByRating() {
    final activePlayers = _players.where((player) => player.isActive).toList();
    activePlayers.sort((a, b) => b.overallRating.compareTo(a.overallRating));
    return activePlayers;
  }

  void addPlayer(Player player) {
    _players.add(player);
  }

  void updatePlayer(Player player) {
    final index = _players.indexWhere((p) => p.id == player.id);
    if (index != -1) {
      _players[index] = player;
    }
  }

  void deletePlayer(String playerId) {
    _players.removeWhere((player) => player.id == playerId);
    _users.removeWhere((user) => user.id == playerId);
  }

  // Matches
  List<Match> get matches => List.unmodifiable(_matches);
  
  Match? getMatchById(String id) {
    try {
      return _matches.firstWhere((match) => match.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Match> getCompletedMatches() {
    return _matches.where((match) => match.status == MatchStatus.completed).toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  List<Match> getUpcomingMatches() {
    return _matches.where((match) => match.status == MatchStatus.scheduled).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  void addMatch(Match match) {
    _matches.add(match);
  }

  void updateMatch(Match match) {
    final index = _matches.indexWhere((m) => m.id == match.id);
    if (index != -1) {
      _matches[index] = match;
    }
  }

  void deleteMatch(String matchId) {
    _matches.removeWhere((match) => match.id == matchId);
  }

  // Messages
  List<Message> get messages => List.unmodifiable(_messages);
  
  List<Message> getGroupMessages() {
    return _messages.where((message) => message.isGroupMessage).toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  List<Message> getPrivateMessages(String userId1, String userId2) {
    return _messages.where((message) => 
      !message.isGroupMessage && (
        (message.senderId == userId1 && message.recipientId == userId2) ||
        (message.senderId == userId2 && message.recipientId == userId1)
      )
    ).toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  List<Message> getConversationsForUser(String userId) {
    final conversations = <String, Message>{};
    
    for (final message in _messages) {
      if (!message.isGroupMessage) {
        String otherUserId;
        if (message.senderId == userId) {
          otherUserId = message.recipientId!;
        } else if (message.recipientId == userId) {
          otherUserId = message.senderId;
        } else {
          continue;
        }
        
        if (!conversations.containsKey(otherUserId) || 
            message.timestamp.isAfter(conversations[otherUserId]!.timestamp)) {
          conversations[otherUserId] = message;
        }
      }
    }
    
    return conversations.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void addMessage(Message message) {
    _messages.add(message);
  }

  void markMessageAsRead(String messageId) {
    final index = _messages.indexWhere((m) => m.id == messageId);
    if (index != -1) {
      _messages[index] = Message(
        id: _messages[index].id,
        senderId: _messages[index].senderId,
        senderName: _messages[index].senderName,
        content: _messages[index].content,
        timestamp: _messages[index].timestamp,
        type: _messages[index].type,
        recipientId: _messages[index].recipientId,
        isRead: true,
      );
    }
  }

  // Statistiques de l'équipe
  Map<String, dynamic> getTeamStatistics() {
    final completedMatches = getCompletedMatches();
    int wins = 0;
    int draws = 0;
    int losses = 0;
    int goalsFor = 0;
    int goalsAgainst = 0;

    for (final match in completedMatches) {
      if (match.result != null) {
        switch (match.result!.outcome) {
          case MatchOutcome.win:
            wins++;
            break;
          case MatchOutcome.draw:
            draws++;
            break;
          case MatchOutcome.loss:
            losses++;
            break;
        }

        if (match.result!.isHomeTeam) {
          goalsFor += match.result!.homeScore;
          goalsAgainst += match.result!.awayScore;
        } else {
          goalsFor += match.result!.awayScore;
          goalsAgainst += match.result!.homeScore;
        }
      }
    }

    return {
      'matchesPlayed': completedMatches.length,
      'wins': wins,
      'draws': draws,
      'losses': losses,
      'goalsFor': goalsFor,
      'goalsAgainst': goalsAgainst,
      'goalDifference': goalsFor - goalsAgainst,
      'points': wins * 3 + draws,
    };
  }

  // Top scorers
  List<Map<String, dynamic>> getTopScorers() {
    final scorers = <String, int>{};
    
    for (final match in getCompletedMatches()) {
      if (match.playerStats != null) {
        match.playerStats!.forEach((playerId, stats) {
          scorers[playerId] = (scorers[playerId] ?? 0) + stats.goals;
        });
      }
    }

    final topScorers = <Map<String, dynamic>>[];
    scorers.forEach((playerId, goals) {
      final player = getPlayerById(playerId);
      if (player != null && goals > 0) {
        topScorers.add({
          'player': player,
          'goals': goals,
        });
      }
    });

    topScorers.sort((a, b) => (b['goals'] as int).compareTo(a['goals'] as int));
    return topScorers;
  }

  // Top assists
  List<Map<String, dynamic>> getTopAssists() {
    final assists = <String, int>{};
    
    for (final match in getCompletedMatches()) {
      if (match.playerStats != null) {
        match.playerStats!.forEach((playerId, stats) {
          assists[playerId] = (assists[playerId] ?? 0) + stats.assists;
        });
      }
    }

    final topAssists = <Map<String, dynamic>>[];
    assists.forEach((playerId, assistCount) {
      final player = getPlayerById(playerId);
      if (player != null && assistCount > 0) {
        topAssists.add({
          'player': player,
          'assists': assistCount,
        });
      }
    });

    topAssists.sort((a, b) => (b['assists'] as int).compareTo(a['assists'] as int));
    return topAssists;
  }
}