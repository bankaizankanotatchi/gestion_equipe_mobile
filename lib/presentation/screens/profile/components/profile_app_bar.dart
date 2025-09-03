import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/data/models/player.dart';
import 'package:team_manager_app/data/models/user.dart';

class ProfileAppBar extends StatelessWidget {
  final User? user;
  final Player? player;

  const ProfileAppBar({
    super.key,
    required this.user,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      stretch: true,
      pinned: true,
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        'MON PROFIL',
        style: AppTextStyles.subtitle2.copyWith(
          color: Colors.transparent,
          fontWeight: FontWeight.bold,
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = constraints.biggest.height;
          final isTitleVisible =
              top < MediaQuery.of(context).size.height * 0.2;

          return FlexibleSpaceBar(
            centerTitle: false,
            title: isTitleVisible
                ? Text(
              'MON PROFIL',
              style: AppTextStyles.subtitle2.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
                : const SizedBox.shrink(),
            stretchModes: const [StretchMode.zoomBackground],
            background: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  // Image de fond si disponible
                  if (user != null && user?.avatar != null)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        user!.avatar!,
                        fit: BoxFit.cover,
                      ),
                    ),

                  // Dégradé sombre en bas pour la lisibilité
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.95),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Avatar et informations
                  Positioned(
                    bottom: AppConstants.paddingLarge,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            user!.name,
                            style: AppTextStyles.heading4.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          if (player != null) ...[
                            const SizedBox(height: AppConstants.paddingSmall),
                            Text(
                              _getPositionName(player!.position),
                              style: AppTextStyles.body1.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
}