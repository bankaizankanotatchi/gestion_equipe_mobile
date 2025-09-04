// lib/presentation/screens/profile/components/app_options_section.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/routing/app_router.dart';

class AppOptionsSection extends StatelessWidget {
  const AppOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          _buildOptionTile(
            context,
            'Notifications',
            Icons.notifications_active,
             AppColors.primary,
            () => context.router.push(const NotificationsRoute()),
          ),
          _buildDivider(),
          _buildOptionTile(
            context,
            'Préférences',
            Icons.settings,
            Colors.grey,
            () => _showInfo(context, 'Préférences de l\'application'),
          ),
          _buildDivider(),
          _buildOptionTile(
            context,
            'Aide et support',
            Icons.help,
            Colors.green,
            () => _showInfo(context, 'Aide et support'),
          ),
          _buildDivider(),
          _buildOptionTile(
            context,
            'À propos',
            Icons.info,
            Colors.purple,
            () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: AppTextStyles.subtitle1),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey.shade400,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade200,
    );
  }

  void _showInfo(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(title)),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('À propos'),
        content: const Text(
          'Team Manager v1.0.0\n\n'
          'Application de gestion d\'équipe sportive.\n'
          'Gérez vos joueurs, matchs et statistiques facilement.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }
}