// lib/presentation/screens/home/widgets/floating_action_button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../providers/auth_provider.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final int currentIndex;
  final AnimationController fabAnimationController;

  const CustomFloatingActionButton({
    super.key,
    required this.currentIndex,
    required this.fabAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    if (!authProvider.isCoach || currentIndex == 4 || currentIndex == 0 || currentIndex == 3) {
      return const SizedBox.shrink();
    }

    return ScaleTransition(
      scale: fabAnimationController,
      child: FloatingActionButton(
        onPressed: () => _onFabPressed(context),
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        child: Icon(_getFabIcon()),
      ),
    );
  }

  IconData _getFabIcon() {
    switch (currentIndex) {
      case 1:
        return Icons.person_add;
      case 2:
        return Icons.add_box;
      default:
        return Icons.add;
    }
  }

  void _onFabPressed(BuildContext context) {
    switch (currentIndex) {
      case 1:
        context.router.push(AddEditPlayerRoute(playerId: null));
        break;
        
      case 2:
        context.router.push(AddMatchRoute(matchId: null));
        break;
      default:
        context.router.push(AddMatchRoute(matchId: null));
        break;
    }
  }
}