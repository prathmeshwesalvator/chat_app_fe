import 'dart:ui';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget qrView(BuildContext context, QrState state) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final brightness = theme.brightness;

  return TweenAnimationBuilder<double>(
    key: const ValueKey('qr'),
    duration: const Duration(milliseconds: 500),
    tween: Tween(begin: 0.0, end: 1.0),
    curve: Curves.easeOut,
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: child,
        ),
      );
    },
    child: Column(
      children: [
        // QR Code Container with Liquid Glass
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: brightness == Brightness.dark
                ? colorScheme.surfaceContainerHighest.withOpacity(0.3)
                : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.white.withOpacity(0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                data: state.qrData?.contactHash ?? '',
                size: 200,
                eyeStyle: QrEyeStyle(
                  color: colorScheme.primary,
                  eyeShape: QrEyeShape.square,
                ),
                dataModuleStyle: QrDataModuleStyle(
                  color: colorScheme.primary,
                  dataModuleShape: QrDataModuleShape.square,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Instruction Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.qrcode_viewfinder,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Scan to add me to your contacts',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget expiredView(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final brightness = theme.brightness;

  return TweenAnimationBuilder<double>(
    key: const ValueKey('expired'),
    duration: const Duration(milliseconds: 500),
    tween: Tween(begin: 0.0, end: 1.0),
    curve: Curves.easeOut,
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: child,
        ),
      );
    },
    child: Column(
      children: [
        // Expired Icon Container
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: brightness == Brightness.dark
                ? colorScheme.errorContainer.withOpacity(0.2)
                : colorScheme.errorContainer.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.error.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Icon(
            CupertinoIcons.qrcode,
            size: 80,
            color: colorScheme.error.withOpacity(0.6),
          ),
        ),

        const SizedBox(height: 20),

        // Expired Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.error.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.clock_fill,
                size: 16,
                color: colorScheme.error,
              ),
              const SizedBox(width: 8),
              Text(
                'This QR has expired',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Regenerate Button
        _RegenerateButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            context.read<QrBloc>().add(GenerateHash());
          },
        ),
      ],
    ),
  );
}

class _RegenerateButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _RegenerateButton({required this.onPressed});

  @override
  State<_RegenerateButton> createState() => _RegenerateButtonState();
}

class _RegenerateButtonState extends State<_RegenerateButton> {
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
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primaryContainer,
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.white.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.refresh_bold,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Regenerate QR',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
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