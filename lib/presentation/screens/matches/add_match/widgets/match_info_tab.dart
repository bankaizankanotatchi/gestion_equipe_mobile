// lib/presentation/screens/matches/widgets/match_info_tab.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/date_time_button.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/glass_input.dart';

class MatchInfoTab extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController opponentController;
  final TextEditingController venueController;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final VoidCallback onDateSelected;
  final VoidCallback onTimeSelected;

  const MatchInfoTab({
    super.key,
    required this.formKey,
    required this.opponentController,
    required this.venueController,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateSelected,
    required this.onTimeSelected,
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
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _buildInfoCard(
              'Informations du Match',
              Icons.sports_soccer,
              Column(
                children: [
                  GlassInput(
                    controller: opponentController,
                    label: 'Équipe Adverse',
                    icon: Icons.shield,
                    validator: (value) => value?.isEmpty == true ? 'Requis' : null,
                  ),
                  const SizedBox(height: 20),
                  GlassInput(
                    controller: venueController,
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
                    child: DateTimeButton(
                      text: DateFormat('dd MMM yyyy').format(selectedDate),
                      icon: Icons.calendar_month,
                      onPressed: onDateSelected,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: DateTimeButton(
                      text: selectedTime.format(context),
                      icon: Icons.access_time,
                      onPressed: onTimeSelected,
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
}