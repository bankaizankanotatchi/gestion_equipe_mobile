import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.avatarSizeSmall),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Image.asset(
        'assets/logos/logo.jpeg',
        width: AppConstants.avatarSizeXLarge * 2.5,
        height: AppConstants.iconSizeXLarge * 2.5,
        fit: BoxFit.contain,
      ),
    );
  }
}
