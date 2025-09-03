import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

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