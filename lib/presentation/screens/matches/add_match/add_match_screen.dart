// lib/presentation/screens/matches/add_match_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/data/models/match.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/content/add_match_content.dart';

enum MatchType { friendly, championship, cup, tournament }

@RoutePage()
class AddMatchScreen extends StatefulWidget {
  final String? matchId;
  const AddMatchScreen({super.key, this.matchId});

  @override
  State<AddMatchScreen> createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _opponentController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  MatchType _selectedMatchType = MatchType.friendly;
  
  final Map<String, bool> _selectedPlayers = {};
  final List<String> _startingEleven = [];
  final List<String> _substitutes = [];
  
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    if (widget.matchId != null) {
      _loadMatchData();
    } else {
      final players = Provider.of<PlayerProvider>(context, listen: false).players;
      for (var player in players) {
        _selectedPlayers[player.id] = false;
      }
    }
    
    _animationController.forward();
  }

  void _loadMatchData() {
    final matchProvider = Provider.of<MatchProvider>(context, listen: false);
    final match = matchProvider.getMatchById(widget.matchId!);
    
    if (match != null) {
      _opponentController.text = match.opponent;
      _venueController.text = match.venue;
      _selectedDate = match.dateTime;
      _selectedTime = TimeOfDay.fromDateTime(match.dateTime);
      
      final players = Provider.of<PlayerProvider>(context, listen: false).players;
      for (var player in players) {
        _selectedPlayers[player.id] = match.selectedPlayers?.contains(player.id) ?? false;
      }
      
      _startingEleven.addAll(match.startingEleven ?? []);
      _substitutes.addAll(match.substitutes ?? []);
    }
  }

  void _togglePlayerInTeam(String playerId) {
    setState(() {
      final isInStarting = _startingEleven.contains(playerId);
      final isInSubs = _substitutes.contains(playerId);
      
      if (isInStarting) {
        _startingEleven.remove(playerId);
      } else if (isInSubs) {
        _substitutes.remove(playerId);
      } else {
        if (_startingEleven.length < 11) {
          _startingEleven.add(playerId);
        } else if (_substitutes.length < 7) {
          _substitutes.add(playerId);
        }
      }
      
      _selectedPlayers[playerId] = _startingEleven.contains(playerId) || _substitutes.contains(playerId);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveMatch() {
    if (_formKey.currentState!.validate()) {
      if (_startingEleven.length != 11) {
        _showErrorSnackBar('Veuillez sélectionner exactement 11 titulaires');
        return;
      }

      if (_opponentController.text.isEmpty || _venueController.text.isEmpty) {
        _showErrorSnackBar('Veuillez remplir tous les champs obligatoires');
        return;
      }

      final matchProvider = Provider.of<MatchProvider>(context, listen: false);
      
      if (widget.matchId != null) {
        final updatedMatch = Match(
          id: widget.matchId!,
          opponent: _opponentController.text,
          venue: _venueController.text,
          dateTime: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute,
          ),
          status: MatchStatus.scheduled,
          selectedPlayers: _selectedPlayers.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList(),
          startingEleven: _startingEleven,
          substitutes: _substitutes,
        );
        
        matchProvider.updateMatch(updatedMatch);
        _showSuccessSnackBar('Match modifié avec succès');
      } else {
        final newMatch = Match(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          opponent: _opponentController.text,
          venue: _venueController.text,
          dateTime: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute,
          ),
          status: MatchStatus.scheduled,
          selectedPlayers: _selectedPlayers.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList(),
          startingEleven: _startingEleven,
          substitutes: _substitutes,
        );
        
        matchProvider.addMatch(newMatch);
        _showSuccessSnackBar('Match créé avec succès');
      }
      
      _animationController.reverse().then((_) {
        Navigator.pop(context);
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  void dispose() {
    _opponentController.dispose();
    _venueController.dispose();
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AddMatchContent(
          formKey: _formKey,
          opponentController: _opponentController,
          venueController: _venueController,
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          selectedMatchType: _selectedMatchType,
          selectedPlayers: _selectedPlayers,
          startingEleven: _startingEleven,
          substitutes: _substitutes,
          tabController: _tabController,
          fadeAnimation: _fadeAnimation,
          onDateSelected: _selectDate,
          onTimeSelected: _selectTime,
          onMatchTypeChanged: (type) => setState(() => _selectedMatchType = type),
          onPlayerToggled: _togglePlayerInTeam,
          onSaveMatch: _saveMatch,
          isEditing: widget.matchId != null,
        ),
      ),
    );
  }
}