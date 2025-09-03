import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class PlayerListCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String emptyMessage;
  final List<dynamic> players;
  final String Function(dynamic) statBuilder;
  final Color positionColor;

  const PlayerListCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.emptyMessage,
    required this.players,
    required this.statBuilder,
    required this.positionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Titre avec icône ---
            Row(
              children: [
                Icon(icon, color: positionColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppTextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),

            // --- Liste ou message vide ---
            if (players.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    emptyMessage,
                    style: AppTextStyles.body2.copyWith(
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ...players.asMap().entries.map((entry) {
                final index = entry.key;
                final playerData = entry.value;
                final player = playerData['player'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: index == 0 ? positionColor.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: index == 0 ? positionColor : Colors.grey.shade200,
                      width: index == 0 ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // --- Classement (1, 2, 3...) ---
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: index == 0 ? positionColor : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // --- Numéro de maillot ---
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: positionColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${player.jerseyNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // --- Nom du joueur ---
                      Expanded(
                        child: Text(
                          player.name,
                          style: AppTextStyles.subtitle2.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // --- Statistique ---
                      Text(
                        statBuilder(playerData),
                        style: AppTextStyles.subtitle2.copyWith(
                          color: positionColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
