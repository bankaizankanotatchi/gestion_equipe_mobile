// lib/presentation/screens/matches/widgets/summary_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/add_match_screen.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/utils/formation_utils.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/utils/match_utils.dart';

class SummaryCard extends StatelessWidget {
  final String opponent;
  final String venue;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final MatchType selectedMatchType;
  final List<String> startingEleven;

  const SummaryCard({
    super.key,
    required this.opponent,
    required this.venue,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedMatchType,
    required this.startingEleven,
  });

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

  @override
  Widget build(BuildContext context) {
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
          _buildSummaryRow('Adversaire', opponent),
          _buildSummaryRow('Stade', venue),
          _buildSummaryRow('Date', DateFormat('dd MMMM yyyy').format(selectedDate)),
          _buildSummaryRow('Heure', selectedTime.format(context)),
          _buildSummaryRow('Type', MatchUtils.getMatchTypeName(selectedMatchType)),
          _buildSummaryRow('Formation', FormationUtils.detectFormation(startingEleven, context)),
        ],
      ),
    );
  }
}