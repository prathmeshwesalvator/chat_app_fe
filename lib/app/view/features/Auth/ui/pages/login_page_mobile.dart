import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/global/utils/haptic_feedback.dart';
import 'package:chat_app_fe/app/view/features/Auth/ui/bloc/login/login_cubit.dart';
import 'package:chat_app_fe/app/view/features/Auth/ui/bloc/login/login_state.dart';
import 'package:chat_app_fe/app/view/features/Auth/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPageMobile extends StatefulWidget {
  const LoginPageMobile({super.key});

  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loginStatus == Blocstatus.success) {
            context.hapticLight();
            context.router.replaceAll([const AppShellRoute()]);
          }

          if (state.loginStatus == Blocstatus.error) {
            context.hapticLight();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(CupertinoIcons.exclamationmark_triangle_fill,
                        color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(child: Text(state.errorMessage)),
                  ],
                ),
                backgroundColor: colors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary,
                colors.primaryContainer,
                colors.primary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Floating orbs background
              Positioned(
                top: -100,
                right: -50,
                child: _FloatingOrb(
                  size: 250,
                  color: colors.primaryContainer.withOpacity(0.3),
                ),
              ),
              Positioned(
                bottom: -80,
                left: -60,
                child: _FloatingOrb(
                  size: 200,
                  color: colors.primary.withOpacity(0.2),
                ),
              ),

              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              const SizedBox(height: 60),

                              // App Icon with Liquid Glass
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: _LiquidAppIcon(colors: colors),
                              ),

                              const SizedBox(height: 24),

                              // App Title
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: Column(
                                  children: [
                                    Text(
                                      'ChatSphere',
                                      style: theme.textTheme.headlineLarge
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.5,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      margin: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.shield_fill,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Private • Fast • Secure',
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Spacer(),

                              // Login Form Card with Liquid Glass
                              SlideTransition(
                                position: _slideAnimation,
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(40),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 20, sigmaY: 20),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color:
                                              colors.surface.withOpacity(0.95),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(40),
                                          ),
                                          border: Border(
                                            top: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              width: 1.5,
                                            ),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 40,
                                              offset: const Offset(0, -10),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            24, 36, 24, 40),
                                        child: Column(
                                          children: [
                                            // Drag indicator
                                            Container(
                                              width: 40,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: colors.onSurface
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                            const SizedBox(height: 32),

                                            LoginForm(
                                              formKey: _formKey,
                                              usernameController:
                                                  _usernameController,
                                              passwordController:
                                                  _passwordController,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiquidAppIcon extends StatelessWidget {
  final ColorScheme colors;

  const _LiquidAppIcon({required this.colors});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            CupertinoIcons.chat_bubble_2_fill,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _FloatingOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _FloatingOrb({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}
