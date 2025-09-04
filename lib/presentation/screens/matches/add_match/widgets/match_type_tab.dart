// lib/presentation/screens/matches/widgets/match_type_tab.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/add_match_screen.dart';
import 'match_type_card.dart';

class MatchTypeTab extends StatelessWidget {
  final MatchType selectedMatchType;
  final Function(MatchType) onMatchTypeChanged;

  const MatchTypeTab({
    super.key,
    required this.selectedMatchType,
    required this.onMatchTypeChanged,
  });

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
                  color:  AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color:  AppColors.primary, size: 24),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildInfoCard(
            'Type de Compétition',
            Icons.emoji_events,
            Column(
              children: MatchType.values.map((type) {
                return MatchTypeCard(
                  type: type,
                  isSelected: selectedMatchType == type,
                  onTap: () => onMatchTypeChanged(type),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}