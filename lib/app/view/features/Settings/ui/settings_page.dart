import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/global/theme/bloc/theme_cubit.dart';
import 'package:chat_app_fe/app/global/theme/bloc/theme_state.dart';
import 'package:chat_app_fe/app/global/utils/haptic_feedback.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_bloc.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _isLoading = false;
  String? _errorMessage;

  late AnimationController _errorController;
  late Animation<double> _errorAnimation;

  @override
  void initState() {
    super.initState();
    _errorController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _errorAnimation = CurvedAnimation(
      parent: _errorController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _errorController.dispose();
    super.dispose();
  }

  void _handleError(String message) {
    if (mounted) {
      setState(() {
        _errorMessage = message;
        _isLoading = false;
      });
      _errorController.forward().then((_) {
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted) {
            _errorController.reverse().then((_) {
              if (mounted) {
                setState(() => _errorMessage = null);
              }
            });
          }
        });
      });

      // Haptic feedback
      HapticFeedback.mediumImpact();
    }
  }

  void _showSuccessMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleLogout() async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Logout'),
            onPressed: () {
              context.read<HomeBloc>().add(LogoutUserEvent());

              context.router.replaceAll([const LoginRoute()]);
            },
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _isLoading = true);

      try {
        // Perform logout
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          // Navigate to login or handle logout
          _showSuccessMessage('Logged out successfully');
        }
      } catch (e) {
        _handleError('Logout failed: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Color _glassColor(ColorScheme scheme, Brightness brightness) {
    if (brightness == Brightness.dark) {
      return scheme.surface.withOpacity(0.45);
    }
    return Colors.white.withOpacity(0.75);
  }

  Color _glassBorder(ColorScheme scheme, Brightness brightness) {
    if (brightness == Brightness.dark) {
      return Colors.white.withOpacity(0.12);
    }
    return Colors.white.withOpacity(0.6);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;

    return BlocBuilder<AppGlobalCubit, AppGlobalState>(
      builder: (context, state) {
        return Stack(
          children: [
            // Animated gradient background
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: brightness == Brightness.dark
                      ? [
                          colorScheme.surface,
                          colorScheme.surfaceContainerHighest,
                          colorScheme.surface,
                        ]
                      : [
                          const Color(0xFFF8FAFF),
                          const Color(0xFFEFF3FF),
                          const Color(0xFFE8F1FF),
                        ],
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: _isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(radius: 16),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(20),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 8),

                        // Error banner
                        if (_errorMessage != null)
                          FadeTransition(
                            opacity: _errorAnimation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.5),
                                end: Offset.zero,
                              ).animate(_errorAnimation),
                              child: _ErrorBanner(
                                message: _errorMessage!,
                                onDismiss: () {
                                  _errorController.reverse().then((_) {
                                    if (mounted) {
                                      setState(() => _errorMessage = null);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),

                        if (_errorMessage != null) const SizedBox(height: 16),

                        _LiquidGlassSection(
                          title: 'Account',
                          glassColor: _glassColor(colorScheme, brightness),
                          borderColor: _glassBorder(colorScheme, brightness),
                          children: [
                            _LiquidSettingsTile(
                              icon: CupertinoIcons.person_circle,
                              title: 'Profile',
                              subtitle: 'Update your personal info',
                              onTap: () {
                                // Navigate to profile
                              },
                            ),
                            _LiquidSettingsTile(
                              icon: CupertinoIcons.lock_shield,
                              title: 'Privacy & Security',
                              subtitle: 'Manage your data',
                              onTap: () {},
                            ),
                            _LiquidSettingsTile(
                              icon: CupertinoIcons.bell,
                              title: 'Notification Settings',
                              subtitle: 'Customize alerts',
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        _LiquidGlassSection(
                          title: 'Preferences',
                          glassColor: _glassColor(colorScheme, brightness),
                          borderColor: _glassBorder(colorScheme, brightness),
                          children: [
                            _LiquidSwitchTile(
                              icon: brightness == Brightness.dark
                                  ? CupertinoIcons.moon_stars_fill
                                  : CupertinoIcons.sun_max_fill,
                              title: 'Dark Mode',
                              value: brightness == Brightness.dark,
                              onChanged: (_) {
                                try {
                                  context.hapticLight();
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    context
                                        .read<AppGlobalCubit>()
                                        .changeTheme();
                                  });
                                } catch (e) {
                                  _handleError('Failed to change theme');
                                }
                              },
                            ),
                            _LiquidSwitchTile(
                              icon: CupertinoIcons.bell_fill,
                              title: 'Push Notifications',
                              subtitle: 'Receive alerts',
                              value: _notificationsEnabled,
                              onChanged: (value) {
                                setState(() => _notificationsEnabled = value);
                                context.hapticLight();
                              },
                            ),
                            _LiquidSwitchTile(
                              icon: CupertinoIcons.speaker_2_fill,
                              title: 'Sound Effects',
                              value: _soundEnabled,
                              onChanged: (value) {
                                setState(() => _soundEnabled = value);
                                context.hapticLight();
                              },
                            ),
                            _LiquidSwitchTile(
                              icon: CupertinoIcons.hand_point_right_fill,
                              title: 'Haptic Feedback',
                              value: context
                                  .read<AppGlobalCubit>()
                                  .state
                                  .hapticFeedback,
                              onChanged: (_) {
                                context.read<AppGlobalCubit>().changeHaptic();
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        _LiquidGlassSection(
                          title: 'Support & Info',
                          glassColor: _glassColor(colorScheme, brightness),
                          borderColor: _glassBorder(colorScheme, brightness),
                          children: [
                            _LiquidSettingsTile(
                              icon: CupertinoIcons.question_circle,
                              title: 'Help & Support',
                              onTap: () {},
                            ),
                            _LiquidSettingsTile(
                              icon: CupertinoIcons.doc_text,
                              title: 'Terms of Service',
                              onTap: () {},
                            ),
                            _LiquidSettingsTile(
                              icon: CupertinoIcons.info_circle,
                              title: 'About',
                              subtitle: 'Version 1.0.0',
                              onTap: () {},
                              showTrailing: false,
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        _LiquidLogoutButton(
                          glassColor: _glassColor(colorScheme, brightness),
                          borderColor: _glassBorder(colorScheme, brightness),
                          textColor: colorScheme.error,
                          onPressed: _handleLogout,
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ErrorBanner({
    required this.message,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.red.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                color: Colors.red[700],
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.red[900],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.xmark_circle_fill),
                color: Colors.red[700],
                onPressed: onDismiss,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiquidGlassSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color glassColor;
  final Color borderColor;

  const _LiquidGlassSection({
    required this.title,
    required this.children,
    required this.glassColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: -4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Text(
                  title.toUpperCase(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _LiquidSettingsTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showTrailing;

  const _LiquidSettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.showTrailing = true,
  });

  @override
  State<_LiquidSettingsTile> createState() => _LiquidSettingsTileState();
}

class _LiquidSettingsTileState extends State<_LiquidSettingsTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        context.hapticLight();
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: _isPressed
                ? theme.colorScheme.onSurface.withOpacity(0.05)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  size: 22,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (widget.showTrailing)
                Icon(
                  CupertinoIcons.chevron_right,
                  size: 20,
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiquidSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _LiquidSwitchTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 22,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class _LiquidLogoutButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color glassColor;
  final Color borderColor;
  final Color textColor;

  const _LiquidLogoutButton({
    required this.onPressed,
    required this.glassColor,
    required this.borderColor,
    required this.textColor,
  });

  @override
  State<_LiquidLogoutButton> createState() => _LiquidLogoutButtonState();
}

class _LiquidLogoutButtonState extends State<_LiquidLogoutButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        HapticFeedback.mediumImpact();
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.96 : 1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: widget.glassColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: widget.borderColor, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: widget.textColor.withOpacity(0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.square_arrow_right,
                    color: widget.textColor,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: widget.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
