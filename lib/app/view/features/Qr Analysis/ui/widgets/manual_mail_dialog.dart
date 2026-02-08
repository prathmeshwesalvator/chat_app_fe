import 'dart:ui';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/utils/haptic_feedback.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showMailEntryDialog(BuildContext context) async {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showUserSection = false;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return BlocConsumer<QrBloc, QrState>(
            listenWhen: (p, c) => p.addContactStatus != c.addContactStatus,
            listener: (context, state) {
              if (state.addContactStatus == Blocstatus.success) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final theme = Theme.of(context);
              final colorScheme = theme.colorScheme;
              final brightness = theme.brightness;
              final isAdding = state.addContactStatus == Blocstatus.loading;

              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: brightness == Brightness.dark
                              ? colorScheme.surface.withOpacity(0.9)
                              : Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: brightness == Brightness.dark
                                ? Colors.white.withOpacity(0.15)
                                : Colors.white.withOpacity(0.6),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    colorScheme.primary,
                                    colorScheme.primaryContainer,
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.primary.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                CupertinoIcons.mail_solid,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Title
                            Text(
                              "Enter Email",
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Text(
                              "Add contact by their email address",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.6),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),

                            /// EMAIL FIELD
                            Form(
                              key: formKey,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: brightness == Brightness.dark
                                      ? colorScheme.surfaceContainerHighest.withOpacity(0.5)
                                      : colorScheme.primaryContainer.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: brightness == Brightness.dark
                                        ? Colors.white.withOpacity(0.1)
                                        : colorScheme.primary.withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: controller,
                                  keyboardType: TextInputType.emailAddress,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "example@mail.com",
                                    hintStyle: TextStyle(
                                      color: colorScheme.onSurface.withOpacity(0.4),
                                    ),
                                    prefixIcon: Icon(
                                      CupertinoIcons.mail,
                                      color: colorScheme.primary,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter email";
                                    }
                                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                      return "Enter valid email";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// USER PREVIEW
                            if (showUserSection)
                              _LiquidMailUserPreview(state: state),

                            const SizedBox(height: 24),

                            /// ACTIONS
                            Row(
                              children: [
                                /// CANCEL
                                Expanded(
                                  child: TextButton(
                                    onPressed: isAdding
                                        ? null
                                        : () {
                                            context.hapticLight();
                                            Navigator.pop(context);
                                          },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.onSurface.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                /// SHOW USER or ADD CONTACT
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () {
                                      if (!showUserSection) {
                                        // Show User
                                        if (!formKey.currentState!.validate()) return;

                                        HapticFeedback.mediumImpact();
                                        context.read<QrBloc>().add(
                                              GetUserInfo(
                                                body: {'mailId': controller.text},
                                              ),
                                            );

                                        setState(() => showUserSection = true);
                                      } else {
                                        // Add Contact
                                        if (state.userInfoStatus == Blocstatus.success &&
                                            !isAdding) {
                                          HapticFeedback.mediumImpact();
                                          context.read<QrBloc>().add(
                                                AddContact(
                                                  body: {'mailId': controller.text},
                                                ),
                                              );
                                        }
                                      }
                                    },
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: isAdding
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation(Colors.white),
                                            ),
                                          )
                                        : Text(
                                            showUserSection ? "Add Contact" : "Show User",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}

class _LiquidMailUserPreview extends StatelessWidget {
  final QrState state;

  const _LiquidMailUserPreview({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;

    if (state.userInfoStatus == Blocstatus.loading) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? colorScheme.surfaceContainerHighest.withOpacity(0.5)
              : colorScheme.primaryContainer.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const CupertinoActivityIndicator(radius: 16),
            const SizedBox(height: 16),
            Text(
              'Loading user info...',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    if (state.userInfoStatus == Blocstatus.error) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
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
                state.errorMessage,
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (state.userInfoStatus == Blocstatus.success && state.userInfo != null) {
      final user = state.userInfo!;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? colorScheme.surfaceContainerHighest.withOpacity(0.5)
              : colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: brightness == Brightness.dark
                ? Colors.white.withOpacity(0.1)
                : colorScheme.primary.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            // Avatar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primaryContainer,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.person_fill,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),

            // User Info
            _UserInfoRow(
              icon: CupertinoIcons.person_fill,
              label: 'Username',
              value: user.username,
            ),
            const SizedBox(height: 12),
            _UserInfoRow(
              icon: CupertinoIcons.person_crop_circle,
              label: 'Name',
              value: user.fullName,
            ),
            const SizedBox(height: 12),
            _UserInfoRow(
              icon: CupertinoIcons.mail_solid,
              label: 'Email',
              value: user.email,
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}

class _UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _UserInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 16, color: colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}