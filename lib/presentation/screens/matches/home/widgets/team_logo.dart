// lib/presentation/screens/matches/widgets/team_logo.dart
import 'package:flutter/material.dart';

class TeamLogo extends StatelessWidget {
  final bool isHomeTeam;

  const TeamLogo({super.key, required this.isHomeTeam});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isHomeTeam ? Colors.transparent : Colors.grey.shade300,
        border: Border.all(
          color: isHomeTeam ? Colors.transparent : Colors.grey.shade400,
          width: 2,
        ),
        image: isHomeTeam 
          ? const DecorationImage(
              image: AssetImage('assets/logos/logo.png'),
              fit: BoxFit.cover,
            )
          : null,
      ),
      child: isHomeTeam 
        ? null
        : Center(
            child: Text(
              'A',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
    );
  }
}