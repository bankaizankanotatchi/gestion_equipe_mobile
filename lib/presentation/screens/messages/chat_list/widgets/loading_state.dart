// lib/presentation/screens/messages/components/loading_state.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: AppConstants.paddingMedium),
          Text('Chargement des conversations...'),
        ],
      ),
    );
  }
}