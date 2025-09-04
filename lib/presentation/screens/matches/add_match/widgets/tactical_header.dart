// lib/presentation/screens/matches/widgets/tactical_header.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/presentation/screens/matches/add_match/widgets/counters/counter_chip.dart';


class TacticalHeader extends StatelessWidget {
  final int startingElevenCount;
  final int substitutesCount;

  const TacticalHeader({
    super.key,
    required this.startingElevenCount,
    required this.substitutesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color:  AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CounterChip(
                label: 'Titulaires',
                current: startingElevenCount,
                max: 11,
                color: Colors.green,
              ),
              CounterChip(
                label: 'Remplaçants',
                current: substitutesCount,
                max: 7,
                color: Colors.orange,
              ),
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
}