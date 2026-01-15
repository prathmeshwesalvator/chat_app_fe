import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/core/networking/api_extensions.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/global/shared_widgets/circular_logo.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_cubit.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_state.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _logoScaleAnimation =
        Tween<double>(begin: 0.9, end: 1.1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.95),
              theme.colorScheme.primaryContainer.withOpacity(0.9),
              theme.colorScheme.secondary.withOpacity(0.85),
            ],
          ),
        ),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.loginStatus == Blocstatus.success) {
              context.router.replaceAll([const HomeRoute()]);
            }

            if (state.loginStatus == Blocstatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: 5.seconds,
                  showCloseIcon: true,
                  content: Text(state.errorMessage,),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  physics: const BouncingScrollPhysics(),
                  child: _buildGlassCard(theme, size),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGlassCard(ThemeData theme, Size size) {
    final bool isDesktop = size.width > 700;

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: isDesktop ? 700 : 380,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.background.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: theme.colorScheme.onBackground.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: _logoScaleAnimation,
                            child: CircularLogo(
                              pulseAnimation: true,
                              pulseDuration:
                                  const Duration(milliseconds: 500),
                              size: 200,
                              shadowColor: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Welcome to ChatSphere',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Connect. Chat. Share.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimary
                                  .withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Right side: Login form
                    Expanded(
                      child: LoginForm(
                        formKey: _formKey,
                        usernameController: usernameController,
                        passwordController: passwordController,
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: CircularLogo(
                        pulseAnimation: true,
                        pulseDuration: const Duration(milliseconds: 500),
                        size: 180,
                        shadowColor: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    LoginForm(
                      formKey: _formKey,
                      usernameController: usernameController,
                      passwordController: passwordController,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'ChatSphere',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Connect. Chat. Share.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimary.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
