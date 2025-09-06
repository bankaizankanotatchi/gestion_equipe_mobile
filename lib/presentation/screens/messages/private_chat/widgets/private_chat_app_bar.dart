// lib/presentation/screens/messages/private_chat/widgets/private_chat_app_bar.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/user.dart';

class PrivateChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User recipient;
  final String Function(User) getUserStatus;

  const PrivateChatAppBar({
    super.key,
    required this.recipient,
    required this.getUserStatus,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(recipient.avatar ?? 'assets/avatars/default_avatar.jpg'),
          ),
          const SizedBox(width: AppConstants.paddingMedium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recipient.name, style: AppTextStyles.subtitle1),
              Text(
                getUserStatus(recipient),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: AppColors.surface,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.call),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
      ],
    );
  }
}