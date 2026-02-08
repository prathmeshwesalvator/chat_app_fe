import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_cubit.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_state.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPageDesktop extends StatefulWidget {
  const LoginPageDesktop({super.key});

  @override
  State<LoginPageDesktop> createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
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
    final brightness = theme.brightness;

    return Scaffold(
      backgroundColor: colors.surface,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loginStatus == Blocstatus.success) {
            context.router.replaceAll([const AppShellRoute()]);
          }

          if (state.loginStatus == Blocstatus.error) {
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
                margin: const EdgeInsets.all(24),
              ),
            );
          }
        },
        child: Row(
          children: [
            /// ───────────────── LEFT BRANDING ─────────────────
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary,
                      colors.primaryContainer,
                      colors.primary.withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    // Floating orbs
                    Positioned(
                      top: -80,
                      left: -80,
                      child: _FloatingOrb(
                        size: 300,
                        color: colors.primaryContainer.withOpacity(0.3),
                      ),
                    ),
                    Positioned(
                      bottom: -100,
                      right: -100,
                      child: _FloatingOrb(
                        size: 350,
                        color: colors.primary.withOpacity(0.2),
                      ),
                    ),

                    SafeArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 64,
                          vertical: 48,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 560),
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // App Icon
                                  _LiquidAppIcon(colors: colors),
                                  
                                  const SizedBox(height: 48),

                                  // Title
                                  Text(
                                    'ChatSphere',
                                    style: theme.textTheme.displayLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -1,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 28),

                                  // Feature list
                                  ...[
                                    ('shield_fill', 'Secure conversations'),
                                    ('bolt_fill', 'Real-time messaging'),
                                    ('person_2_fill', 'Built for teams'),
                                  ].map((feature) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: _FeatureItem(
                                      icon: _getIconData(feature.$1),
                                      text: feature.$2,
                                      theme: theme,
                                    ),
                                  )),

                                  const SizedBox(height: 40),

                                  // Divider
                                  Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.0),
                                          Colors.white.withOpacity(0.3),
                                          Colors.white.withOpacity(0.0),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  // Subtitle
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.3),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.building_2_fill,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                'Enterprise-grade chat platform',
                                                style: theme.textTheme.titleMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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

            /// ───────────────── RIGHT LOGIN CARD ─────────────────
            Expanded(
              flex: 2,
              child: Container(
                color: brightness == Brightness.dark
                    ? colors.surface
                    : const Color(0xFFF8FAFF),
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 32),
                                decoration: BoxDecoration(
                                  color: brightness == Brightness.dark
                                      ? colors.surface.withOpacity(0.6)
                                      : Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: brightness == Brightness.dark
                                        ? Colors.white.withOpacity(0.15)
                                        : Colors.white.withOpacity(0.6),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      offset: const Offset(0, 20),
                                      spreadRadius: -5,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(48),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header with icon
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                colors.primary,
                                                colors.primaryContainer,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                color: colors.primary.withOpacity(0.3),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            CupertinoIcons.lock_shield_fill,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Welcome back',
                                                style: theme.textTheme.headlineMedium?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                  color: colors.onSurface,
                                                  letterSpacing: 0.3,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Sign in to continue',
                                                style: theme.textTheme.bodyMedium?.copyWith(
                                                  color: colors.onSurface.withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 40),

                                    // Login Form
                                    LoginForm(
                                      formKey: _formKey,
                                      usernameController: _usernameController,
                                      passwordController: _passwordController,
                                    ),

                                    const SizedBox(height: 32),

                                    // Footer
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colors.surfaceContainerHighest.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              CupertinoIcons.shield_fill,
                                              size: 14,
                                              color: colors.primary,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '© ${DateTime.now().year} ChatSphere',
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                color: colors.onSurface.withOpacity(0.7),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'shield_fill':
        return CupertinoIcons.shield_fill;
      case 'bolt_fill':
        return CupertinoIcons.bolt_fill;
      case 'person_2_fill':
        return CupertinoIcons.person_2_fill;
      default:
        return CupertinoIcons.circle;
    }
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final ThemeData theme;

  const _FeatureItem({
    required this.icon,
    required this.text,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

class _LiquidAppIcon extends StatelessWidget {
  final ColorScheme colors;

  const _LiquidAppIcon({required this.colors});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 25,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            CupertinoIcons.chat_bubble_2_fill,
            size: 40,
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