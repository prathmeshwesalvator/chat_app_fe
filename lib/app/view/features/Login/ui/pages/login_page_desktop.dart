import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_cubit.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_state.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPageDesktop extends StatefulWidget {
  const LoginPageDesktop({super.key});

  @override
  State<LoginPageDesktop> createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

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
                content: Text(state.errorMessage),
                backgroundColor: colors.error,
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
                    colors: [colors.primary, colors.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 64,
                      vertical: 48,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ChatSphere',
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: colors.onPrimary,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Secure conversations.\n'
                              'Real-time messaging.\n'
                              'Built for teams.',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: colors.onPrimary.withOpacity(0.9),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Divider(
                              color: colors.onPrimary.withOpacity(0.2),
                              thickness: 1,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Enterprise-grade chat platform',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colors.onPrimary.withOpacity(0.7),
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

            /// ───────────────── RIGHT LOGIN CARD ─────────────────
            Expanded(
              flex: 2,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 36,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Header
                          Text(
                            'Welcome back',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in to continue to ChatSphere',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant.withOpacity(0.8),
                            ),
                          ),

                          const SizedBox(height: 32),

                          /// Login Form
                          LoginForm(
                            formKey: _formKey,
                            usernameController: _usernameController,
                            passwordController: _passwordController,
                          ),

                          const SizedBox(height: 32),

                          /// Footer
                          Center(
                            child: Text(
                              '© ${DateTime.now().year} ChatSphere',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
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
    );
  }
}
