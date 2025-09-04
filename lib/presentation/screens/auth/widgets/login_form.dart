// lib/presentation/screens/auth/widgets/login_form.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/presentation/screens/auth/widgets/email_field.dart';
import 'package:team_manager_app/presentation/screens/auth/widgets/error_message.dart';
import 'package:team_manager_app/presentation/screens/auth/widgets/login_button.dart';
import 'package:team_manager_app/presentation/screens/auth/widgets/password_field.dart';
import '../../../providers/auth_provider.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final String? errorMessage;
  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onLogin;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.errorMessage,
    required this.onPasswordVisibilityChanged,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Connexion',
              style: AppTextStyles.heading3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              'Connectez-vous pour accéder à votre équipe',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            EmailField(controller: emailController),
            const SizedBox(height: AppConstants.paddingMedium),
            PasswordField(
              controller: passwordController,
              isPasswordVisible: isPasswordVisible,
              onVisibilityChanged: onPasswordVisibilityChanged,
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: AppConstants.paddingMedium),
              ErrorMessage(message: errorMessage!),
            ],
            const SizedBox(height: AppConstants.paddingLarge),
            LoginButton(
              onLogin: onLogin,
              isLoading: context.watch<AuthProvider>().isLoading,
            ),
          ],
        ),
      ),
    );
  }
}