import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_cubit.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool obscurePassword = true;

    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: isDarkMode
                ? Colors.grey[900]!.withOpacity(0.8)
                : Colors.white.withOpacity(0.95),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: widget.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Welcome Text
                    Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue to ChatSphere',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Username Field
                    TextFormField(
                      controller: widget.usernameController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Username or Email',
                        labelStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your username'
                          : null,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      controller: widget.passwordController,
                      obscureText: obscurePassword,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                      ),
                      validator: (value) => value == null || value.length < 4
                          ? 'Password must be at least 4 characters'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Add forgot password functionality
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: state.loginStatus == Blocstatus.loading
                            ? null
                            : () {
                                if (widget.formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().onLoginSUbmit(
                                    widget.usernameController.text.trim(),
                                    widget.passwordController.text.trim(),
                                  );
                                }

                                if (state.loginStatus == Blocstatus.success) {
                                  context.router.push(const AppShellRoute());
                                }
                              },
                        child: state.loginStatus == Blocstatus.loading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Signing in...',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign In',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_right, size: 20),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: theme.colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or continue with',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: theme.colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
