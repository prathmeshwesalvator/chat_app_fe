import 'dart:async';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/utils/haptic_feedback.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_bloc.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_state.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/open_dialog.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/qr_view.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ShowQrPage extends StatefulWidget {
  const ShowQrPage({super.key});

  @override
  State<ShowQrPage> createState() => _ShowQrPageState();
}

class _ShowQrPageState extends State<ShowQrPage> with TickerProviderStateMixin {
  Timer? _timer;
  final ValueNotifier<int> _remainingSeconds = ValueNotifier(0);
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    final qrBloc = context.read<QrBloc>();
    qrBloc.add(GenerateHash());

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final state = qrBloc.state;

      final createdAt = DateTime.tryParse(state.qrData?.createdAt ?? '');
      if (createdAt == null) {
        _remainingSeconds.value = 0;
        return;
      }

      final remaining = createdAt
          .add(const Duration(minutes: 5))
          .difference(DateTime.now())
          .inSeconds
          .clamp(0, 300);

      _remainingSeconds.value = remaining;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _remainingSeconds.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  Color _glassColor(ColorScheme scheme, Brightness brightness) {
    if (brightness == Brightness.dark) {
      return scheme.surface.withOpacity(0.5);
    }
    return Colors.white.withOpacity(0.85);
  }

  Color _glassBorder(ColorScheme scheme, Brightness brightness) {
    if (brightness == Brightness.dark) {
      return Colors.white.withOpacity(0.15);
    }
    return Colors.white.withOpacity(0.6);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;

    return BlocConsumer<QrBloc, QrState>(
      listener: (context, state) {
        if (state.addContactStatus == Blocstatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(CupertinoIcons.exclamationmark_triangle_fill,
                      color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Failed to add contact ${state.errorMessage}'),
                  ),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.red,
              margin: const EdgeInsets.all(16),
            ),
          );
        }

        if (state.addContactStatus == Blocstatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(CupertinoIcons.checkmark_circle_fill,
                      color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(child: Text('Contact Added successfully')),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.green,
              margin: const EdgeInsets.all(16),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.qrStatus == Blocstatus.loading) {
          return ShimmerLoader(colorScheme: colorScheme);
        }

        if (state.qrStatus != Blocstatus.success) {
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main QR Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _glassColor(colorScheme, brightness),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: _glassBorder(colorScheme, brightness),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withOpacity(0.15),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                                spreadRadius: -5,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(28),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Avatar and Info Section
                                BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, homeState) {
                                    return Row(
                                      children: [
                                        _LiquidAvatar(colorScheme: colorScheme),
                                        const SizedBox(width: 18),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                homeState.username,
                                                style: theme
                                                    .textTheme.titleLarge
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.3,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: colorScheme
                                                      .primaryContainer
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .shield_lefthalf_fill,
                                                      size: 14,
                                                      color:
                                                          colorScheme.primary,
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Flexible(
                                                      child: Text(
                                                        'Secure sharing',
                                                        style: theme
                                                            .textTheme.bodySmall
                                                            ?.copyWith(
                                                          color: colorScheme
                                                              .primary,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                const SizedBox(height: 28),

                                // QR Code Section
                                ValueListenableBuilder<int>(
                                  valueListenable: _remainingSeconds,
                                  builder: (_, remaining, __) {
                                    final isExpired = remaining <= 0;

                                    return AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      switchInCurve: Curves.easeInOut,
                                      switchOutCurve: Curves.easeInOut,
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: ScaleTransition(
                                            scale: animation,
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: isExpired
                                          ? expiredView(context)
                                          : qrView(context, state),
                                    );
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Divider with gradient
                                Container(
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        colorScheme.outlineVariant
                                            .withOpacity(0),
                                        colorScheme.outlineVariant,
                                        colorScheme.outlineVariant
                                            .withOpacity(0),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Status Row
                                ValueListenableBuilder<int>(
                                  valueListenable: _remainingSeconds,
                                  builder: (_, remaining, __) {
                                    final isExpired = remaining <= 0;

                                    return _LiquidStatusRow(
                                      isExpired: isExpired,
                                      remainingSeconds: remaining,
                                      formatter: _formatTime,
                                      pulseAnimation: _pulseAnimation,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Add Contact Button
                    _LiquidButton(
                      onPressed: () {
                        context.hapticLight();
                        openDialog(context);
                      },
                      glassColor: _glassColor(colorScheme, brightness),
                      borderColor: _glassBorder(colorScheme, brightness),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.person_add_solid,
                            size: 20,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Add Contact',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
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

class _LiquidAvatar extends StatelessWidget {
  final ColorScheme colorScheme;

  const _LiquidAvatar({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: brightness == Brightness.dark
              ? [
                  colorScheme.primary.withOpacity(0.8),
                  colorScheme.primaryContainer,
                ]
              : [
                  colorScheme.primary,
                  colorScheme.primaryContainer,
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 3,
          ),
        ),
        child: const Icon(
          CupertinoIcons.person_fill,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _LiquidStatusRow extends StatelessWidget {
  final bool isExpired;
  final int remainingSeconds;
  final String Function(int) formatter;
  final Animation<double> pulseAnimation;

  const _LiquidStatusRow({
    required this.isExpired,
    required this.remainingSeconds,
    required this.formatter,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isExpired
            ? colorScheme.errorContainer.withOpacity(0.3)
            : Colors.green.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpired
              ? colorScheme.error.withOpacity(0.3)
              : Colors.green.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale:
                isExpired ? const AlwaysStoppedAnimation(1.0) : pulseAnimation,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: isExpired ? colorScheme.error : Colors.green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isExpired ? colorScheme.error : Colors.green)
                        .withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            isExpired ? CupertinoIcons.clock_fill : CupertinoIcons.timer_fill,
            size: 16,
            color: isExpired ? colorScheme.error : Colors.green.shade700,
          ),
          const SizedBox(width: 6),
          Text(
            isExpired
                ? 'QR expired'
                : 'Expires in ${formatter(remainingSeconds)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: isExpired ? colorScheme.error : Colors.green.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class _LiquidButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color glassColor;
  final Color borderColor;
  final Widget child;

  const _LiquidButton({
    required this.onPressed,
    required this.glassColor,
    required this.borderColor,
    required this.child,
  });

  @override
  State<_LiquidButton> createState() => _LiquidButtonState();
}

class _LiquidButtonState extends State<_LiquidButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              decoration: BoxDecoration(
                color: widget.glassColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.borderColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
