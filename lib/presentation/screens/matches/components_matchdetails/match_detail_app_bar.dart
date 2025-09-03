import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import 'package:team_manager_app/presentation/providers/auth_provider.dart';
import 'package:team_manager_app/presentation/providers/match_provider.dart';
import 'package:team_manager_app/core/constants/colors.dart';

class MatchDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String matchId;

  const MatchDetailAppBar({super.key, required this.matchId});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Détails du match'),
      backgroundColor: AppColors.surface,
      elevation: 0,
      actions: [
        Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.isCoach) {
              return PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Modifier'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Supprimer'),
                  ),
                ],
                onSelected: (value) => _handleMenuAction(context, value),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        context.router.push(AddMatchRoute(matchId: matchId));
        break;
      case 'delete':
        _showDeleteDialog(context);
        break;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le match'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce match ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<MatchProvider>(context, listen: false).deleteMatch(matchId);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}