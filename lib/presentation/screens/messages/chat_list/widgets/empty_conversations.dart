// lib/presentation/screens/messages/components/empty_conversations.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';

class EmptyConversations extends StatelessWidget {
  final bool isCoach;

  const EmptyConversations({
    super.key,
    required this.isCoach,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            isCoach 
              ? 'Commencez une discussion avec vos joueurs'
              : 'Aucune conversation privée',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          if (isCoach)
            ElevatedButton(
              onPressed: () => _startNewChat(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Nouvelle conversation'),
            ),
        ],
      ),
    );
  }

  void _startNewChat(BuildContext context) {
    context.router.push(const NewChatRoute());
  }
}