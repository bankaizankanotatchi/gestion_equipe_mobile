import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import 'package:team_manager_app/presentation/providers/player_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/data/models/match.dart';
import 'package:team_manager_app/data/models/player.dart';

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
  
  int _currentStep = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMatchInfoTab(),
                    _buildMatchTypeTab(),
                    _buildTacticalTab(),
                    _buildSummaryTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.matchId != null ? 'Modifier le Match' : 'Nouveau Match',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Configuration tactique avancée',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.save, color: Colors.white),
              onPressed: _saveMatch,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildTabBar() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: TabBar(
      controller: _tabController,
      indicator: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: const EdgeInsets.all(4),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey.shade700,
      labelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      splashBorderRadius: BorderRadius.circular(10),
      tabs: const [
        Tab(
          icon: Icon(Icons.info_outline, size: 18),
          text: 'INFO',
        ),
        Tab(
          icon: Icon(Icons.emoji_events, size: 18),
          text: 'TYPE',
        ),
        Tab(
          icon: Icon(Icons.sports_soccer, size: 18),
          text: 'TACTIQUE',
        ),
        Tab(
          icon: Icon(Icons.visibility, size: 18),
          text: 'RÉSUMÉ',
        ),
      ],
    ),
  );
}
  Widget _buildMatchInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildInfoCard(
              'Informations du Match',
              Icons.sports_soccer,
              Column(
                children: [
                  _buildGlassInput(
                    controller: _opponentController,
                    label: 'Équipe Adverse',
                    icon: Icons.shield,
                    validator: (value) => value?.isEmpty == true ? 'Requis' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildGlassInput(
                    controller: _venueController,
                    label: 'Stade',
                    icon: Icons.stadium,
                    validator: (value) => value?.isEmpty == true ? 'Requis' : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              'Date & Heure',
              Icons.schedule,
              Row(
                children: [
                  Expanded(
                    child: _buildDateTimeButton(
                      DateFormat('dd MMM yyyy').format(_selectedDate),
                      Icons.calendar_month,
                      _selectDate,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: _buildDateTimeButton(
                      _selectedTime.format(context),
                      Icons.access_time,
                      _selectTime,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchTypeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildInfoCard(
            'Type de Compétition',
            Icons.emoji_events,
            Column(
              children: MatchType.values.map((type) {
                return _buildMatchTypeCard(type);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTacticalTab() {
    final players = Provider.of<PlayerProvider>(context).players;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildTacticalHeader(),
          const SizedBox(height: 20),
          _buildPositionTabs(players),
        ],
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 20),
          _buildTacticalPreview(),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, Widget content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          content,
        ],
      ),
    );
  }

  Widget _buildGlassInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildDateTimeButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchTypeCard(MatchType type) {
    final isSelected = _selectedMatchType == type;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => setState(() => _selectedMatchType = type),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  _getMatchTypeIcon(type),
                  color: isSelected ? Colors.white : AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getMatchTypeName(type),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getMatchTypeDescription(type),
                        style: TextStyle(
                          color: isSelected ? Colors.white.withOpacity(0.8) : Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTacticalHeader() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCounterChip('Titulaires', _startingEleven.length, 11, Colors.green),
              _buildCounterChip('Remplaçants', _substitutes.length, 7, Colors.orange),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Sélectionnez d\'abord 11 titulaires, puis les remplaçants',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCounterChip(String label, int current, int max, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: current == max ? color : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$label: $current/$max',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionTabs(List<Player> players) {
    final positions = [Position.goalkeeper, Position.defender, Position.midfielder, Position.forward];
    
    return DefaultTabController(
      length: positions.length,
      child: Column(
        children: [
          TabBar(
  labelColor: AppColors.primary,
  unselectedLabelColor: Colors.grey.shade600,
  indicator: const UnderlineTabIndicator(
    borderSide: BorderSide(
      width: 3.0,
      color: AppColors.primary,
    ),
    insets:  EdgeInsets.symmetric(horizontal: 16.0),
  ),
  indicatorSize: TabBarIndicatorSize.label,
  labelStyle: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  ),
  unselectedLabelStyle: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  tabs: positions.map((position) {
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getPositionIcon(position), size: 20),
          const SizedBox(height: 4),
          Text(
            _getPositionName(position), 
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }).toList(),
),
          const SizedBox(height: 20),
          SizedBox(
          height: MediaQuery.of(context).size.width < 400 ? 400 : 
                  MediaQuery.of(context).size.width < 500 ? 500 : 800,
          child: TabBarView(
            children: positions.map((position) {
              final positionPlayers = players.where((p) => p.position == position).toList();
              return _buildPlayerGrid(positionPlayers);
            }).toList(),
          ),
        ),
        ],
      ),
    );
  }

Widget _buildPlayerGrid(List<Player> players) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Déterminer le nombre de colonnes en fonction de la largeur
      final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
      
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return _buildPlayerCard(player);
        },
      );
    },
  );
}
  Widget _buildPlayerCard(Player player) {
    final isInStarting = _startingEleven.contains(player.id);
    final isInSubs = _substitutes.contains(player.id);
    final isSelected = isInStarting || isInSubs;
    
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _togglePlayerInTeam(player.id),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: _getPositionColor(player.position),
                      child: Text(
                        player.jerseyNumber.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isInStarting ? Colors.green : Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isInStarting ? Icons.star : Icons.person,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  player.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getPositionColor(player.position).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getPositionAbbreviation(player.position),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Résumé du Match',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildSummaryRow('Adversaire', _opponentController.text),
          _buildSummaryRow('Stade', _venueController.text),
          _buildSummaryRow('Date', DateFormat('dd MMMM yyyy').format(_selectedDate)),
          _buildSummaryRow('Heure', _selectedTime.format(context)),
          _buildSummaryRow('Type', _getMatchTypeName(_selectedMatchType)),
          _buildSummaryRow('Formation', _detectFormation()),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          Text(
            value.isEmpty ? 'Non défini' : value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildTacticalPreview() {
  if (_startingEleven.length != 11) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: const Center(
        child: Text(
          'Sélectionnez 11 titulaires pour voir l\'aperçu tactique',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  
  return LayoutBuilder(
    builder: (context, constraints) {
      // Utiliser la largeur disponible moins une marge
      final containerWidth = constraints.maxWidth - 40;
      // Maintenir le ratio d'un terrain de football (1.85:1)
      final containerHeight = containerWidth * 1.85;
      
      return Container(
        height: containerHeight,
        width: containerWidth,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: _buildFootballPitch(containerWidth, containerHeight),
      );
    },
  );
}

  Widget _buildFootballPitch(double containerWidth, double containerHeight) {
    final playerProvider = Provider.of<PlayerProvider>(context);
    final startingPlayers = _startingEleven
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = constraints.maxWidth;
        final containerHeight = containerWidth * 1.85; // Ratio d'un terrain de football
        
        return Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Fond de pelouse
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2D5016),
                        Color(0xFF4A7C59),
                        Color(0xFF5D8B3A),
                        Color(0xFF4A7C59),
                        Color(0xFF2D5016),
                      ],
                      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                
                // Rayures de pelouse
                ...List.generate(25, (index) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    top: (index * (containerHeight / 25)).toDouble(),
                    child: Container(
                      height: containerHeight / 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade800.withOpacity(index % 2 == 0 ? 0.15 : 0.05),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  );
                }),
                
                // Lignes du terrain
                CustomPaint(
                  size: Size(containerWidth, containerHeight),
                  painter: FootballPitchPainter(),
                ),
                
                // Placement des joueurs
                ..._positionPlayersRealistic(startingPlayers, containerWidth, context),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _positionPlayersRealistic(List<Player> players, double containerWidth, BuildContext context) {
    final positions = <Widget>[];
    
    // Grouper les joueurs par position
    final goalkeepers = players.where((p) => p.position == Position.goalkeeper).toList();
    final defenders = players.where((p) => p.position == Position.defender).toList();
    final midfielders = players.where((p) => p.position == Position.midfielder).toList();
    final forwards = players.where((p) => p.position == Position.forward).toList();
    
    // Dimensions en pourcentage de la largeur du conteneur
    final double fieldWidth = containerWidth * 0.75;  // 75% de la largeur
    final double fieldHeight = fieldWidth * 1.85;     // Ratio hauteur/largeur d'un terrain
    final double centerX = containerWidth / 2;        // Centre horizontal
    final double sideMargin = (containerWidth - fieldWidth) / 2; // Marge latérale
    
    // Zones verticales en pourcentage de la hauteur
    final double goalKeeperY = fieldHeight * 1;  // 100% de la hauteur
    final double defenseY = fieldHeight * 0.78;     // 78% de la hauteur
    final double midfieldY = fieldHeight * 0.5;     // 50% de la hauteur
    final double attackY = fieldHeight * 0.22;      // 22% de la hauteur
    
    // Positionner le gardien (toujours centré)
    if (goalkeepers.isNotEmpty) {
      positions.add(_buildRealisticPlayer(goalkeepers[0], Offset(centerX, goalKeeperY), context));
    }
    
    // Positionner les défenseurs
    _positionDefenders(defenders, positions, fieldWidth, sideMargin, defenseY, centerX, context);
    
    // Positionner les milieux
    _positionMidfielders(midfielders, positions, fieldWidth, sideMargin, midfieldY, centerX, context);
    
    // Positionner les attaquants
    _positionForwards(forwards, positions, fieldWidth, sideMargin, attackY, centerX, context);
    
    return positions;
  }

  // Fonctions de positionnement avec espacements en pourcentage
  void _positionDefenders(List<Player> defenders, List<Widget> positions, 
      double fieldWidth, double sideMargin, double defenseY, double centerX, BuildContext context) {
    final count = defenders.length;
    if (count == 0) return;

    // Calculer les espacements en pourcentage de la largeur
    final spacing = fieldWidth * 0.08;
    
    switch (count) {
      case 1:
        positions.add(_buildRealisticPlayer(defenders[0], Offset(centerX, defenseY), context));
        break;
      case 2:
        positions.add(_buildRealisticPlayer(defenders[0], Offset(centerX - spacing, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[1], Offset(centerX + spacing, defenseY), context));
        break;
      case 3:
        positions.add(_buildRealisticPlayer(defenders[0], Offset(centerX - spacing * 1.8, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[1], Offset(centerX, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[2], Offset(centerX + spacing * 1.8, defenseY), context));
        break;
      case 4:
        positions.add(_buildRealisticPlayer(defenders[0], Offset(sideMargin + spacing, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[1], Offset(centerX - spacing * 1.1, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[2], Offset(centerX + spacing * 1.1, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[3], Offset(fieldWidth + sideMargin - spacing, defenseY), context));
        break;
      case 5:
        positions.add(_buildRealisticPlayer(defenders[0], Offset(sideMargin + spacing * 0.5, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[1], Offset(centerX - spacing * 1.2, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[2], Offset(centerX, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[3], Offset(centerX + spacing * 1.2, defenseY), context));
        positions.add(_buildRealisticPlayer(defenders[4], Offset(fieldWidth + sideMargin - spacing * 0.5, defenseY), context));
        break;
      default:
        // Répartition équitable
        final step = fieldWidth / (count - 1);
        for (int i = 0; i < count; i++) {
          final x = sideMargin + (i * step);
          positions.add(_buildRealisticPlayer(defenders[i], Offset(x, defenseY), context));
        }
    }
  }

  void _positionMidfielders(List<Player> midfielders, List<Widget> positions,
      double fieldWidth, double sideMargin, double midfieldY, double centerX, BuildContext context) {
    final count = midfielders.length;
    if (count == 0) return;

    final spacing = fieldWidth * 0.08;
    
    switch (count) {
      case 1:
        positions.add(_buildRealisticPlayer(midfielders[0], Offset(centerX, midfieldY), context));
        break;
      case 2:
        positions.add(_buildRealisticPlayer(midfielders[0], Offset(centerX - spacing, midfieldY), context));
        positions.add(_buildRealisticPlayer(midfielders[1], Offset(centerX + spacing, midfieldY), context));
        break;
      case 3:
        positions.add(_buildRealisticPlayer(midfielders[0], Offset(centerX - spacing * 1.8, midfieldY), context));
        positions.add(_buildRealisticPlayer(midfielders[1], Offset(centerX, midfieldY - spacing * 0.5), context));
        positions.add(_buildRealisticPlayer(midfielders[2], Offset(centerX + spacing * 1.8, midfieldY), context));
        break;
      case 4:
        positions.add(_buildRealisticPlayer(midfielders[0], Offset(sideMargin + spacing, midfieldY), context));
        positions.add(_buildRealisticPlayer(midfielders[1], Offset(centerX - spacing * 1.1, midfieldY + spacing * 0.5), context));
        positions.add(_buildRealisticPlayer(midfielders[2], Offset(centerX + spacing * 1.1, midfieldY + spacing * 0.5), context));
        positions.add(_buildRealisticPlayer(midfielders[3], Offset(fieldWidth + sideMargin - spacing, midfieldY), context));
        break;
      case 5:
        positions.add(_buildRealisticPlayer(midfielders[0], Offset(sideMargin + spacing * 0.5, midfieldY), context));
        positions.add(_buildRealisticPlayer(midfielders[1], Offset(centerX - spacing * 1.2, midfieldY + spacing * 0.3), context));
        positions.add(_buildRealisticPlayer(midfielders[2], Offset(centerX, midfieldY - spacing * 0.3), context));
        positions.add(_buildRealisticPlayer(midfielders[3], Offset(centerX + spacing * 1.2, midfieldY + spacing * 0.3), context));
        positions.add(_buildRealisticPlayer(midfielders[4], Offset(fieldWidth + sideMargin - spacing * 0.5, midfieldY), context));
        break;
      default:
        final step = fieldWidth / (count - 1);
        for (int i = 0; i < count; i++) {
          final x = sideMargin + (i * step);
          positions.add(_buildRealisticPlayer(midfielders[i], Offset(x, midfieldY), context));
        }
    }
  }

  void _positionForwards(List<Player> forwards, List<Widget> positions,
      double fieldWidth, double sideMargin, double attackY, double centerX, BuildContext context) {
    final count = forwards.length;
    if (count == 0) return;

    final spacing = fieldWidth * 0.08;
    
    switch (count) {
      case 1:
        positions.add(_buildRealisticPlayer(forwards[0], Offset(centerX, attackY), context));
        break;
      case 2:
        positions.add(_buildRealisticPlayer(forwards[0], Offset(centerX - spacing * 1.5, attackY), context));
        positions.add(_buildRealisticPlayer(forwards[1], Offset(centerX + spacing * 1.5, attackY), context));
        break;
      case 3:
        positions.add(_buildRealisticPlayer(forwards[0], Offset(centerX - spacing * 2.2, attackY + spacing * 0.3), context));
        positions.add(_buildRealisticPlayer(forwards[1], Offset(centerX, attackY - spacing * 0.4), context));
        positions.add(_buildRealisticPlayer(forwards[2], Offset(centerX + spacing * 2.2, attackY + spacing * 0.3), context));
        break;
      case 4:
        positions.add(_buildRealisticPlayer(forwards[0], Offset(sideMargin + spacing, attackY), context));
        positions.add(_buildRealisticPlayer(forwards[1], Offset(centerX - spacing, attackY), context));
        positions.add(_buildRealisticPlayer(forwards[2], Offset(centerX + spacing, attackY), context));
        positions.add(_buildRealisticPlayer(forwards[3], Offset(fieldWidth + sideMargin - spacing, attackY), context));
        break;
      case 5:
        positions.add(_buildRealisticPlayer(forwards[0], Offset(sideMargin + spacing * 0.5, attackY), context));
        positions.add(_buildRealisticPlayer(forwards[1], Offset(centerX - spacing * 1.5, attackY + spacing * 0.3), context));
        positions.add(_buildRealisticPlayer(forwards[2], Offset(centerX, attackY - spacing * 0.3), context));
        positions.add(_buildRealisticPlayer(forwards[3], Offset(centerX + spacing * 1.5, attackY + spacing * 0.3), context));
        positions.add(_buildRealisticPlayer(forwards[4], Offset(fieldWidth + sideMargin - spacing * 0.5, attackY), context));
        break;
      default:
        final step = fieldWidth / (count - 1);
        for (int i = 0; i < count; i++) {
          final x = sideMargin + (i * step);
          positions.add(_buildRealisticPlayer(forwards[i], Offset(x, attackY), context));
        }
    }
  }

  Widget _buildRealisticPlayer(Player player, Offset position, BuildContext context) {
    return Positioned(
      left: position.dx - 20,
      top: position.dy - 25,
      child: SizedBox(
        width: 40,
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cercle du joueur avec numéro
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    _getPositionColor(player.position),
                    _getPositionColor(player.position).withOpacity(0.8),
                  ],
                  stops: const [0.0, 1.0],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  player.jerseyNumber.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 1,
                        offset: const Offset(0, 0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 3),
            
            // Nom du joueur
            Container(
              width: 40,
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                _getShortName(player.name),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            const SizedBox(height: 2),
            
            // Poste du joueur
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              decoration: BoxDecoration(
                color: _getPositionColor(player.position),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
              child: Text(
                _getPositionAbbreviation(player.position),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 6,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getShortName(String fullName) {
    final names = fullName.split(' ');
    if (names.length == 1) return fullName;
    return '${names[0]} ${names[1][0]}.';
  }

  // Méthodes utilitaires
  IconData _getMatchTypeIcon(MatchType type) {
    switch (type) {
      case MatchType.friendly:
        return Icons.handshake;
      case MatchType.championship:
        return Icons.emoji_events;
      case MatchType.cup:
        return Icons.military_tech;
      case MatchType.tournament:
        return Icons.emoji_events;
    }
  }

  String _getMatchTypeName(MatchType type) {
    switch (type) {
      case MatchType.friendly:
        return 'Match Amical';
      case MatchType.championship:
        return 'Championnat';
      case MatchType.cup:
        return 'Coupe';
      case MatchType.tournament:
        return 'Tournoi';
    }
  }

  String _getMatchTypeDescription(MatchType type) {
    switch (type) {
      case MatchType.friendly:
        return 'Match d\'entraînement sans enjeu';
      case MatchType.championship:
        return 'Match de championnat officiel';
      case MatchType.cup:
        return 'Match à élimination directe';
      case MatchType.tournament:
        return 'Match de tournoi';
    }
  }

  IconData _getPositionIcon(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return Icons.sports_hockey;
      case Position.defender:
        return Icons.security;
      case Position.midfielder:
        return Icons.swap_horiz;
      case Position.forward:
        return Icons.sports_soccer;
    }
  }

  String _getPositionName(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'gardiens';
      case Position.defender:
        return 'défenseurs';
      case Position.midfielder:
        return 'milieux';
      case Position.forward:
        return 'attaquants';
    }
  }

  Color _getPositionColor(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return AppColors.goalkeeper;
      case Position.defender:
        return AppColors.defender;
      case Position.midfielder:
        return AppColors.midfielder;
      case Position.forward:
        return AppColors.forward;
    }
  }

  String _getPositionAbbreviation(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'GB';
      case Position.defender:
        return 'DEF';
      case Position.midfielder:
        return 'MIL';
      case Position.forward:
        return 'ATT';
    }
  }

  void _togglePlayerInTeam(String playerId) {
    setState(() {
      final isInStarting = _startingEleven.contains(playerId);
      final isInSubs = _substitutes.contains(playerId);
      
      if (isInStarting) {
        // Retirer des titulaires
        _startingEleven.remove(playerId);
      } else if (isInSubs) {
        // Retirer des remplaçants
        _substitutes.remove(playerId);
      } else {
        // Ajouter selon la priorité
        if (_startingEleven.length < 11) {
          _startingEleven.add(playerId);
        } else if (_substitutes.length < 7) {
          _substitutes.add(playerId);
        }
      }
      
      // Mettre à jour la sélection générale
      _selectedPlayers[playerId] = _startingEleven.contains(playerId) || _substitutes.contains(playerId);
    });
  }

  String _detectFormation() {
    if (_startingEleven.length != 11) return 'Non définie';
    
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    final startingPlayers = _startingEleven
        .map((id) => playerProvider.getPlayerById(id))
        .where((player) => player != null)
        .cast<Player>()
        .toList();

    int defenders = startingPlayers.where((p) => p.position == Position.defender).length;
    int midfielders = startingPlayers.where((p) => p.position == Position.midfielder).length;
    int forwards = startingPlayers.where((p) => p.position == Position.forward).length;
    
    // Formations classiques
    if (defenders == 4 && midfielders == 4 && forwards == 2) return '4-4-2';
    if (defenders == 4 && midfielders == 3 && forwards == 3) return '4-3-3';
    if (defenders == 3 && midfielders == 5 && forwards == 2) return '3-5-2';
    if (defenders == 3 && midfielders == 4 && forwards == 3) return '3-4-3';
    if (defenders == 5 && midfielders == 3 && forwards == 2) return '5-3-2';
    if (defenders == 4 && midfielders == 5 && forwards == 1) return '4-5-1';
    
    return '$defenders-$midfielders-$forwards';
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
        // Mode édition
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
        // Mode création
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
      
      // Animation de fermeture
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
}

class FootballPitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final width = size.width;
    final height = size.height;

    // Bordures du terrain
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, width, height),
        const Radius.circular(8),
      ),
      paint,
    );

    // Ligne médiane
    canvas.drawLine(
      Offset(0, height / 2),
      Offset(width, height / 2),
      paint,
    );

    // Cercle central
    final centerX = width / 2;
    final centerY = height / 2;
    canvas.drawCircle(
      Offset(centerX, centerY),
      40,
      paint,
    );
    
    // Point central
    canvas.drawCircle(
      Offset(centerX, centerY),
      3,
      Paint()..color = Colors.white..style = PaintingStyle.fill,
    );

    // Surface de réparation supérieure (équipe adverse)
    final penaltyAreaWidth = width * 0.4;
    final penaltyAreaHeight = 80.0;
    final penaltyLeft = (width - penaltyAreaWidth) / 2;
    
    canvas.drawRect(
      Rect.fromLTWH(penaltyLeft, 0, penaltyAreaWidth, penaltyAreaHeight),
      paint,
    );

    // Surface de but supérieure
    final goalAreaWidth = width * 0.2;
    final goalAreaHeight = 30.0;
    final goalLeft = (width - goalAreaWidth) / 2;
    
    canvas.drawRect(
      Rect.fromLTWH(goalLeft, 0, goalAreaWidth, goalAreaHeight),
      paint,
    );

    // Arc de cercle surface de réparation supérieure
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, penaltyAreaHeight),
        width: 60,
        height: 60,
      ),
      -0.0472, 
      3.0944,  // 120 degrés en radians
      false,
      paint,
    );

    // Point de penalty supérieur
    canvas.drawCircle(
      Offset(centerX, 55),
      3,
      Paint()..color = Colors.white..style = PaintingStyle.fill,
    );

    // Surface de réparation inférieure (notre équipe)
    canvas.drawRect(
      Rect.fromLTWH(penaltyLeft, height - penaltyAreaHeight, penaltyAreaWidth, penaltyAreaHeight),
      paint,
    );

    // Surface de but inférieure
    canvas.drawRect(
      Rect.fromLTWH(goalLeft, height - goalAreaHeight, goalAreaWidth, goalAreaHeight),
      paint,
    );

    // Arc de cercle surface de réparation inférieure
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, height - penaltyAreaHeight),
        width: 60,
        height: 60,
      ),
      3.0944,  
      3.0944,  // 120 degrés en radians
      false,
      paint,
    );

    // Point de penalty inférieur
    canvas.drawCircle(
      Offset(centerX, height - 55),
      3,
      Paint()..color = Colors.white..style = PaintingStyle.fill,
    );

    // Coins du terrain
    final cornerRadius = 8.0;
    
    // Coin supérieur gauche
    canvas.drawArc(
      Rect.fromLTWH(0, 0, cornerRadius * 2, cornerRadius * 2),
      0, // 0 degrés
      1.5708, // 90 degrés en radians
      false,
      paint,
    );
    
    // Coin supérieur droit
    canvas.drawArc(
      Rect.fromLTWH(width - cornerRadius * 2, 0, cornerRadius * 2, cornerRadius * 2),
      1.5708, // 90 degrés
      1.5708, // 90 degrés
      false,
      paint,
    );
    
    // Coin inférieur gauche
    canvas.drawArc(
      Rect.fromLTWH(0, height - cornerRadius * 2, cornerRadius * 2, cornerRadius * 2),
      4.7124, // 270 degrés
      1.5708, // 90 degrés
      false,
      paint,
    );
    
    // Coin inférieur droit
    canvas.drawArc(
      Rect.fromLTWH(width - cornerRadius * 2, height - cornerRadius * 2, cornerRadius * 2, cornerRadius * 2),
      3.1416, // 180 degrés
      1.5708, // 90 degrés
      false,
      paint,
    );

    // Buts (représentés par des rectangles plus épais)
    final goalPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final goalWidth = width * 0.15;
    final goalLeft2 = (width - goalWidth) / 2;
    
    // But supérieur
    canvas.drawRect(
      Rect.fromLTWH(goalLeft2, -8, goalWidth, 8),
      goalPaint,
    );
    
    // But inférieur
    canvas.drawRect(
      Rect.fromLTWH(goalLeft2, height, goalWidth, 8),
      goalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}