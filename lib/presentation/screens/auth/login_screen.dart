// lib/presentation/screens/auth/login_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager_app/core/routing/app_router.dart';
import '../../providers/auth_provider.dart';
import '../../../core/constants/colors.dart';
import 'animations/login_animations.dart';
import 'content/login_content.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _errorMessage;
  
  late LoginAnimations _animations;

  @override
  void initState() {
    super.initState();
    _animations = LoginAnimations(this);
    _animations.setupAnimations();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animations.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _errorMessage = null;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!success) {
      setState(() {
        _errorMessage = 'Email ou mot de passe incorrect';
      });
    } else {
      if (mounted) {
        context.router.replace(const HomeRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _animations.animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _animations.fadeAnimation,
                child: SlideTransition(
                  position: _animations.slideAnimation,
                  child: LoginContent(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    isPasswordVisible: _isPasswordVisible,
                    errorMessage: _errorMessage,
                    onPasswordVisibilityChanged: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    onLogin: _login,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}