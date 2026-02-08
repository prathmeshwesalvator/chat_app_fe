import 'dart:ui';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget expiredView(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final brightness = theme.brightness;

  return TweenAnimationBuilder<double>(
    key: const ValueKey('expired'),
    duration: const Duration(milliseconds: 600),
    tween: Tween(begin: 0.0, end: 1.0),
    curve: Curves.easeOutBack,
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Transform.scale(
          scale: 0.7 + (0.3 * value),
          child: child,
        ),
      );
    },
    child: Column(
      children: [
        // Expired Icon Container with Pulsing Animation
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1500),
          tween: Tween(begin: 1.0, end: 1.1),
          curve: Curves.easeInOut,
          builder: (context, pulseValue, child) {
            return Transform.scale(
              scale: pulseValue,
              child: child,
            );
          },
          onEnd: () {
            // Restart animation (this will be handled by the AnimatedBuilder rebuild)
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow ring
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colorScheme.error.withOpacity(0.2),
                      colorScheme.error.withOpacity(0.0),
                    ],
                  ),
                ),
              ),

              // Main icon container
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: brightness == Brightness.dark
                      ? colorScheme.errorContainer.withOpacity(0.3)
                      : colorScheme.errorContainer.withOpacity(0.4),
                  border: Border.all(
                    color: colorScheme.error.withOpacity(0.4),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.error.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  CupertinoIcons.qrcode,
                  size: 100,
                  color: colorScheme.error.withOpacity(0.7),
                ),
              ),

              // X mark overlay
              Positioned(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.error.withOpacity(0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Expired Text Badge
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.error.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.clock_fill,
                    size: 18,
                    color: colorScheme.error,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'This QR has expired',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.error,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 28),

        // Regenerate Button
        _LiquidRegenerateButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            context.read<QrBloc>().add(GenerateHash());
          },
          colorScheme: colorScheme,
          brightness: brightness,
        ),
      ],
    ),
  );
}

class _LiquidRegenerateButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ColorScheme colorScheme;
  final Brightness brightness;

  const _LiquidRegenerateButton({
    required this.onPressed,
    required this.colorScheme,
    required this.brightness,
  });

  @override
  State<_LiquidRegenerateButton> createState() =>
      _LiquidRegenerateButtonState();
}

class _LiquidRegenerateButtonState extends State<_LiquidRegenerateButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AnimatedBuilder(
              animation: _shimmerAnimation,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.colorScheme.primary,
                        widget.colorScheme.primaryContainer,
                        widget.colorScheme.primary,
                      ],
                      stops: [
                        0.0,
                        0.5 + (_shimmerAnimation.value * 0.1),
                        1.0,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white.withOpacity(0.6),
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.colorScheme.primary.withOpacity(0.4),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  child: child,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.refresh_bold,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Regenerate QR',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
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
