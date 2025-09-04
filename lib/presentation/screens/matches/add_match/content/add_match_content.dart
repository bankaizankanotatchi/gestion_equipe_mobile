// lib/presentation/screens/matches/content/add_match_content.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/add_match_screen.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/add_match_header.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/match_info_tab.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/match_tab_bar.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/match_type_tab.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/summary_tab.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/tactical_tab.dart';

class AddMatchContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController opponentController;
  final TextEditingController venueController;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final MatchType selectedMatchType;
  final Map<String, bool> selectedPlayers;
  final List<String> startingEleven;
  final List<String> substitutes;
  final TabController tabController;
  final Animation<double> fadeAnimation;
  final VoidCallback onDateSelected;
  final VoidCallback onTimeSelected;
  final Function(MatchType) onMatchTypeChanged;
  final Function(String) onPlayerToggled;
  final VoidCallback onSaveMatch;
  final bool isEditing;

  const AddMatchContent({
    super.key,
    required this.formKey,
    required this.opponentController,
    required this.venueController,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedMatchType,
    required this.selectedPlayers,
    required this.startingEleven,
    required this.substitutes,
    required this.tabController,
    required this.fadeAnimation,
    required this.onDateSelected,
    required this.onTimeSelected,
    required this.onMatchTypeChanged,
    required this.onPlayerToggled,
    required this.onSaveMatch,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddMatchHeader(
          isEditing: isEditing,
          onSaveMatch: onSaveMatch,
          onBack: () => Navigator.pop(context),
        ),
        MatchTabBar(tabController: tabController),
        Expanded(
          child: FadeTransition(
            opacity: fadeAnimation,
            child: TabBarView(
              controller: tabController,
              children: [
                MatchInfoTab(
                  formKey: formKey,
                  opponentController: opponentController,
                  venueController: venueController,
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                  onDateSelected: onDateSelected,
                  onTimeSelected: onTimeSelected,
                ),
                MatchTypeTab(
                  selectedMatchType: selectedMatchType,
                  onMatchTypeChanged: onMatchTypeChanged,
                ),
                TacticalTab(
                  selectedPlayers: selectedPlayers,
                  startingEleven: startingEleven,
                  substitutes: substitutes,
                  onPlayerToggled: onPlayerToggled,
                ),
                SummaryTab(
                  opponent: opponentController.text,
                  venue: venueController.text,
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                  selectedMatchType: selectedMatchType,
                  startingEleven: startingEleven,
                  substitutes: substitutes,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}