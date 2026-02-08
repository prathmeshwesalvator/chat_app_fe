import 'dart:ui';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/utils/haptic_feedback.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/manual_mail_dialog.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openDialog(BuildContext context) async {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final brightness = theme.brightness;

  await showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                        CupertinoIcons.person_add_solid,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      'Add Contact',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'Choose how you want to add',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Option 1: Scan QR
                    _DialogOption(
                      icon: CupertinoIcons.qrcode_viewfinder,
                      title: 'Scan QR Code',
                      subtitle: 'Use camera to scan',
                      onTap: () async {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(dialogContext);

                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QrScannerPage(),
                          ),
                        );

                        if (result != null && context.mounted) {
                          addingResultPopup(
                            context,
                            "You are adding",
                            result.toString(),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 12),

                    // Option 2: Manual Entry
                    _DialogOption(
                      icon: CupertinoIcons.textformat_abc,
                      title: 'Enter Email',
                      subtitle: 'Add manually by email',
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(dialogContext);
                        showMailEntryDialog(context);
                      },
                    ),

                    const SizedBox(height: 20),

                    // Cancel Button
                    TextButton(
                      onPressed: () {
                        context.hapticLight();
                        Navigator.pop(dialogContext);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}

class _DialogOption extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DialogOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<_DialogOption> createState() => _DialogOptionState();
}

class _DialogOptionState extends State<_DialogOption> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: brightness == Brightness.dark
                ? colorScheme.surfaceContainerHighest.withOpacity(0.5)
                : colorScheme.primaryContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.1)
                  : colorScheme.primary.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  widget.icon,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                color: colorScheme.onSurface.withOpacity(0.4),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showResultPopup(
  BuildContext context,
  String title,
  String value,
) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (_) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(CupertinoIcons.info_circle_fill, color: colorScheme.primary),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
        content: SelectableText(
          value,
          style: theme.textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("OK", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    ),
  );
}

Future<void> addingResultPopup(
  BuildContext context,
  String title,
  String value,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (_) {
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

          /// LOADING USER INFO
          if (state.userInfoStatus == Blocstatus.loading) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: brightness == Brightness.dark
                            ? colorScheme.surface.withOpacity(0.9)
                            : Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CupertinoActivityIndicator(radius: 20),
                          const SizedBox(height: 20),
                          Text(
                            'Loading user info...',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
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

          /// ERROR
          if (state.userInfoStatus == Blocstatus.error) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                backgroundColor: brightness == Brightness.dark
                    ? colorScheme.surface
                    : Colors.white,
                title: const Row(
                  children: [
                    Icon(CupertinoIcons.exclamationmark_triangle_fill, color: Colors.red),
                    SizedBox(width: 12),
                    Text("Error"),
                  ],
                ),
                content: Text(
                  state.errorMessage,
                  style: theme.textTheme.bodyLarge,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("OK", style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            );
          }

          /// SUCCESS USER FETCH
          if (state.userInfoStatus == Blocstatus.success &&
              state.userInfo != null) {
            final user = state.userInfo!;
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
                      ),
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Avatar
                          Container(
                            padding: const EdgeInsets.all(20),
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
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Title
                          Text(
                            title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // User Info Card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _InfoRow(
                                  icon: CupertinoIcons.person_fill,
                                  label: 'Username',
                                  value: user.username,
                                ),
                                const SizedBox(height: 12),
                                _InfoRow(
                                  icon: CupertinoIcons.person_crop_circle,
                                  label: 'Name',
                                  value: user.fullName,
                                ),
                                const SizedBox(height: 12),
                                _InfoRow(
                                  icon: CupertinoIcons.mail_solid,
                                  label: 'Email',
                                  value: user.email,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Actions
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: isAdding ? null : () => Navigator.pop(context),
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
                              Expanded(
                                child: FilledButton(
                                  onPressed: isAdding
                                      ? null
                                      : () {
                                          HapticFeedback.mediumImpact();
                                          context.read<QrBloc>().add(
                                                AddContact(body: {'contactHash': value}),
                                              );
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
                                            valueColor: AlwaysStoppedAnimation(Colors.white),
                                          ),
                                        )
                                      : const Text(
                                          "Add Contact",
                                          style: TextStyle(fontWeight: FontWeight.w700),
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
          }

          return const SizedBox();
        },
      );
    },
  );
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
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
        Icon(icon, size: 18, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
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