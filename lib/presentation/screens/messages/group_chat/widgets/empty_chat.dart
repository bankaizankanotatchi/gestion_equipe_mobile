// lib/presentation/screens/messages/group_chat/components/empty_chat.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';

class EmptyChat extends StatelessWidget {
  final VoidCallback onStartChat;

  const EmptyChat({
    super.key,
    required this.onStartChat,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.forum_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Démarrez la conversation !',
            style: AppTextStyles.heading5.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Envoyez le premier message à l\'équipe',
            style: AppTextStyles.body2.copyWith(
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          FloatingActionButton(
            onPressed: onStartChat,
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add_comment, color: Colors.white),
          ),
        ],
      ),
    );
  }
}