// lib/presentation/screens/notifications/components/loading_state.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: AppConstants.paddingLarge),
          Text('Chargement des notifications...'),
        ],
      ),
    );
  }
}