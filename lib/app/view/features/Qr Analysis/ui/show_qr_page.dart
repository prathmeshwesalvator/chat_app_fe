import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_cubit.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/expired_view.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/qr_view.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ShowQrPage extends StatefulWidget {
  const ShowQrPage({super.key});

  @override
  State<ShowQrPage> createState() => _ShowQrPageState();
}

class _ShowQrPageState extends State<ShowQrPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<QrBloc>().add(GenerateHash());

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<QrBloc, QrState>(
      builder: (context, state) {
        if (state.qrStatus == Blocstatus.loading) {
          return ShimmerLoader(colorScheme: colorScheme);
        }

        if (state.qrStatus != Blocstatus.success) {
          return const SizedBox.shrink();
        }

        final userState = context.read<HomeCubit>().state;
        final createdAt = DateTime.tryParse(state.qrData?.createdAt ?? '');

        final remainingSeconds = createdAt == null
            ? 0
            : createdAt
                  .add(const Duration(minutes: 5))
                  .difference(DateTime.now())
                  .inSeconds
                  .clamp(0, 300);

        final isExpired = remainingSeconds <= 0;

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Card(
              elevation: 8,
              shadowColor: colorScheme.primary.withOpacity(.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Avatar
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: colorScheme.primary.withOpacity(.1),
                      child: Icon(
                        Icons.person,
                        size: 42,
                        color: colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// Username
                    Text(
                      userState.username,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Share your contact securely',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// QR / Expired Switch
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: isExpired
                          ? expiredView(context)
                          : qrView(context, state),
                    ),

                    const SizedBox(height: 20),

                    Divider(height: 1, color: colorScheme.outlineVariant),

                    const SizedBox(height: 14),

                    /// Status Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: isExpired ? colorScheme.error : Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isExpired
                              ? 'QR expired'
                              : 'Expires in ${_formatTime(remainingSeconds)}',
                          style: theme.textTheme.bodySmall,
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
