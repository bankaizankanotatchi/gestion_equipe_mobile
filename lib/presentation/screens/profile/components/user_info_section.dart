import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/data/models/user.dart';

class UserInfoSection extends StatelessWidget {
  final User user;
  final Player? player;

  const UserInfoSection({
    super.key,
    required this.user,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          children: [
            Text(
              user.name,
              style: AppTextStyles.heading3.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              user.email,
              style: AppTextStyles.body2.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLarge,
                vertical: AppConstants.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: _getUserTypeColor(user.type),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getUserTypeLabel(user.type),
                style: AppTextStyles.subtitle2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (player != null) ...[
              const SizedBox(height: AppConstants.paddingMedium),
              _buildPlayerQuickInfo(player!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerQuickInfo(Player player) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildInfoChip('N°${player.jerseyNumber}', Icons.confirmation_number),
        const SizedBox(width: AppConstants.paddingSmall),
        _buildInfoChip(_getPositionName(player.position), Icons.sports),
        const SizedBox(width: AppConstants.paddingSmall),
        _buildInfoChip('${player.age} ans', Icons.cake),
      ],
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _getPositionName(Position position) {
    switch (position) {
      case Position.goalkeeper:
        return 'Gardien';
      case Position.defender:
        return 'Défenseur';
      case Position.midfielder:
        return 'Milieu';
      case Position.forward:
        return 'Attaquant';
    }
  }

  Color _getUserTypeColor(UserType type) {
    switch (type) {
      case UserType.coach:
        return Colors.orange;
      case UserType.player:
        return AppColors.primary;
      default:
        return Colors.grey;
    }
  }

  String _getUserTypeLabel(UserType type) {
    switch (type) {
      case UserType.coach:
        return 'ENTRAÎNEUR';
      case UserType.player:
        return 'JOUEUR';
      default:
        return 'UTILISATEUR';
    }
  }
}