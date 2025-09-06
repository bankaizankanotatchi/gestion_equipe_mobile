// lib/presentation/screens/messages/new_chat/widgets/empty_state.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';

class EmptyState extends StatelessWidget {
  final String searchQuery;

  const EmptyState({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_off,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Text(
            searchQuery.isEmpty ? 'Aucun membre disponible' : 'Aucun résultat',
            style: AppTextStyles.heading5.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            searchQuery.isEmpty
                ? 'Tous les membres sont déjà en conversation'
                : 'Aucun membre ne correspond à "$searchQuery"',
            style: AppTextStyles.body2.copyWith(
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}