// lib/presentation/screens/matches/widgets/summary_tab.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/add_match_screen.dart';
import 'summary_card.dart';
import 'tactical_preview.dart';

class SummaryTab extends StatelessWidget {
  final String opponent;
  final String venue;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final MatchType selectedMatchType;
  final List<String> startingEleven;
  final List<String> substitutes;

  const SummaryTab({
    super.key,
    required this.opponent,
    required this.venue,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedMatchType,
    required this.startingEleven,
    required this.substitutes,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SummaryCard(
            opponent: opponent,
            venue: venue,
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            selectedMatchType: selectedMatchType,
            startingEleven: startingEleven,
          ),
          const SizedBox(height: 20),
          TacticalPreview(
            startingEleven: startingEleven,
            substitutes: substitutes,
          ),
        ],
      ),
    );
  }
}