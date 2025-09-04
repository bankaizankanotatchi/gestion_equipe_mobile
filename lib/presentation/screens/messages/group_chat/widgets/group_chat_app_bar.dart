import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/presentation/providers/message_provider.dart';

class GroupChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroupChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessageProvider>(context, listen: true);
    final messages = messageProvider.groupMessages;

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DISCUSSION D\'ÉQUIPE',
            style: AppTextStyles.subtitle2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            '${messages.length} messages • ${_getOnlineCount()} en ligne',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontSize: 11,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primary,
      elevation: 2,
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, size: 22),
          onPressed: _showGroupInfo,
          tooltip: 'Informations du groupe',
        ),
        IconButton(
          icon: const Icon(Icons.people_alt, size: 22),
          onPressed: _showMembers,
          tooltip: 'Membres du groupe',
        ),
      ],
    );
  }

  int _getOnlineCount() {
    return 8 + DateTime.now().second % 5;
  }

  void _showGroupInfo() {
    // Implémentation du dialogue d'information
  }

  void _showMembers() {
    // Implémentation de l'affichage des membres
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
