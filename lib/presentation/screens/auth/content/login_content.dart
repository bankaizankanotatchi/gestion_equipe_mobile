// lib/presentation/screens/auth/content/login_content.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/presentation/screens/auth/widgets/demo_credentials.dart';
import 'package:team_manager_app/presentation/screens/auth/widgets/login_form.dart';
import 'package:team_manager_app/presentation/screens/auth/widgets/login_logo.dart';
class LoginContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final String? errorMessage;
  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onLogin;

  const LoginContent({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.errorMessage,
    required this.onPasswordVisibilityChanged,
    required this.onLogin,
  });

  void _handleAccountSelected(String email, String password) {
    emailController.text = email;
    passwordController.text = password;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginLogo(),
            const SizedBox(height: AppConstants.paddingXLarge),
            LoginForm(
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
              isPasswordVisible: isPasswordVisible,
              errorMessage: errorMessage,
              onPasswordVisibilityChanged: onPasswordVisibilityChanged,
              onLogin: onLogin,
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            DemoCredentials(
              onAccountSelected: _handleAccountSelected,
            ),
          ],
        ),
      ),
    );
  }
}