
// lib/presentation/screens/players/add_edit_player_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/data/models/statistics.dart';
import '../../providers/player_provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/player.dart';

@RoutePage()
class AddEditPlayerScreen extends StatefulWidget {
  final String? playerId;

  const AddEditPlayerScreen({
    super.key,
    this.playerId,
  });

  @override
  State<AddEditPlayerScreen> createState() => _AddEditPlayerScreenState();
}

class _AddEditPlayerScreenState extends State<AddEditPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _jerseyNumberController = TextEditingController();
  
  Position _selectedPosition = Position.midfielder;
  
  final Map<String, int> _stats = {
    'pace': 50,
    'shooting': 50,
    'passing': 50,
    'dribbling': 50,
    'defending': 50,
    'physical': 50,
  };

  bool get isEditing => widget.playerId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _loadPlayerData();
    }
  }

  void _loadPlayerData() {
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    final player = playerProvider.getPlayerById(widget.playerId!);
    
    if (player != null) {
      _nameController.text = player.name;
      _ageController.text = player.age.toString();
      _jerseyNumberController.text = player.jerseyNumber.toString();
      _selectedPosition = player.position;
      
      _stats['pace'] = player.stats.pace;
      _stats['shooting'] = player.stats.shooting;
      _stats['passing'] = player.stats.passing;
      _stats['dribbling'] = player.stats.dribbling;
      _stats['defending'] = player.stats.defending;
      _stats['physical'] = player.stats.physical;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier le joueur' : 'Ajouter un joueur'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBasicInfo(),
              const SizedBox(height: AppConstants.paddingLarge),
              _buildStatsSection(),
              const SizedBox(height: AppConstants.paddingLarge),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations de base',
              style: AppTextStyles.heading5,
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom complet',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir le nom du joueur';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Âge',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requis';
                      }
                      final age = int.tryParse(value);
                      if (age == null || age < 16 || age > 45) {
                        return 'Âge invalide';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: AppConstants.paddingMedium),
                Expanded(
                  child: TextFormField(
                    controller: _jerseyNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Numéro',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requis';
                      }
                      final number = int.tryParse(value);
                      if (number == null || number < 1 || number > 99) {
                        return 'Numéro invalide';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            DropdownButtonFormField<Position>(
              value: _selectedPosition,
              decoration: const InputDecoration(
                labelText: 'Position',
                prefixIcon: Icon(Icons.sports_soccer),
              ),
              items: Position.values.map((position) {
                return DropdownMenuItem(
                  value: position,
                  child: Text(_getPositionName(position)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPosition = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistiques',
              style: AppTextStyles.heading5,
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            ..._stats.entries.map((entry) {
              return _buildStatSlider(entry.key, entry.value);
            }),
            const SizedBox(height: AppConstants.paddingMedium),
            _buildOverallRating(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatSlider(String statName, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_getStatDisplayName(statName), style: AppTextStyles.body1),
              Text(
                value.toString(),
                style: AppTextStyles.subtitle2.copyWith(
                  color: _getStatColor(value),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Slider(
            value: value.toDouble(),
            min: 1,
            max: 99,
            divisions: 98,
            activeColor: _getStatColor(value),
            onChanged: (newValue) {
              setState(() {
                _stats[statName] = newValue.round();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
    final overallRating = _stats.values.reduce((a, b) => a + b) ~/ _stats.length;
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: _getStatColor(overallRating).withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Note globale',
            style: AppTextStyles.subtitle1,
          ),
          Text(
            overallRating.toString(),
            style: AppTextStyles.heading4.copyWith(
              color: _getStatColor(overallRating),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _savePlayer,
          child: Text(isEditing ? 'Modifier' : 'Ajouter'),
        ),
        const SizedBox(height: AppConstants.paddingSmall),
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
      ],
    );
  }

  void _savePlayer() {
    if (_formKey.currentState!.validate()) {
      final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
      
      final player = Player(
        id: isEditing ? widget.playerId! : DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text),
        position: _selectedPosition,
        jerseyNumber: int.parse(_jerseyNumberController.text),
        stats: PlayerStats(
          pace: _stats['pace']!,
          shooting: _stats['shooting']!,
          passing: _stats['passing']!,
          dribbling: _stats['dribbling']!,
          defending: _stats['defending']!,
          physical: _stats['physical']!,
        ),
        joinDate: isEditing 
            ? playerProvider.getPlayerById(widget.playerId!)!.joinDate
            : DateTime.now(),
      );

      if (isEditing) {
        playerProvider.updatePlayer(player);
      } else {
        playerProvider.addPlayer(player);
      }

      Navigator.pop(context);
    }
  }

  String _getPositionName(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'Gardien de but';
      case Position.defender:
        return 'Défenseur';
      case Position.midfielder:
        return 'Milieu de terrain';
      case Position.forward:
        return 'Attaquant';
    }
  }

  String _getStatDisplayName(String statName) {
    switch (statName) {
      case 'pace':
        return 'Vitesse';
      case 'shooting':
        return 'Tir';
      case 'passing':
        return 'Passes';
      case 'dribbling':
        return 'Dribble';
      case 'defending':
        return 'Défense';
      case 'physical':
        return 'Physique';
      default:
        return statName;
    }
  }

  Color _getStatColor(int value) {
    if (value >= 85) return AppColors.excellent;
    if (value >= 70) return AppColors.good;
    if (value >= 55) return AppColors.average;
    return AppColors.poor;
  }
}
