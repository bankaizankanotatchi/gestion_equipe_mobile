import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors.dart';
import '../../../providers/auth_provider.dart';
import '../../matches/add_match_screen.dart';
import '../../players/add_edit_player_screen.dart';

class FloatingactionbuttonWidget extends StatefulWidget {
  final int currentIndex; // ✅ paramètre reçu

  const FloatingactionbuttonWidget({super.key, required this.currentIndex});

  @override
  State<FloatingactionbuttonWidget> createState() => _FloatingactionbuttonWidgetState();
}

class _FloatingactionbuttonWidgetState extends State<FloatingactionbuttonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabAnimationController;

  IconData _getFabIcon() {
    switch (widget.currentIndex) {
      case 1:
        return Icons.person_add;
      case 2:
        return Icons.add_box;
      default:
        return Icons.add;
    }
  }

  void _onFabPressed() {
    switch (widget.currentIndex) {
      case 1:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => AddEditPlayerScreen(playerId: null),
        ));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => AddMatchScreen(matchId: null),
        ));
        break;
      default:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => AddMatchScreen(matchId: null),
        ));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: AppConstants.animationDurationMedium,
      vsync: this,
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isCoach ||
        widget.currentIndex == 4 ||
        widget.currentIndex == 0 ||
        widget.currentIndex == 3) {
      return const SizedBox.shrink();
    }

    return ScaleTransition(
      scale: _fabAnimationController,
      child: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        child: Icon(_getFabIcon()),
      ),
    );
  }
}
