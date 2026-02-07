import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_bloc.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_state.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/open_dialog.dart';
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
  final ValueNotifier<int> _remainingSeconds = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

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

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  shadowColor: colorScheme.primary.withOpacity(.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _AvatarSection(colorScheme: colorScheme),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.username,
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Share your contact securely',
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 22),

                        ValueListenableBuilder<int>(
                          valueListenable: _remainingSeconds,
                          builder: (_, remaining, __) {
                            final isExpired = remaining <= 0;

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 350),
                              child: isExpired
                                  ? expiredView(context)
                                  : qrView(context, state),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        Divider(height: 1, color: colorScheme.outlineVariant),

                        const SizedBox(height: 14),

                        /// Status
                        ValueListenableBuilder<int>(
                          valueListenable: _remainingSeconds,
                          builder: (_, remaining, __) {
                            final isExpired = remaining <= 0;

                            return _StatusRow(
                              isExpired: isExpired,
                              remainingSeconds: remaining,
                              formatter: _formatTime,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton.icon(
                    icon: const Icon(Icons.add_outlined),
                    onPressed: () {
                      openDialog(context);
                    },
                    label: const Text('Add Contact'))
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AvatarSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const _AvatarSection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 48,
      backgroundColor: colorScheme.primary.withOpacity(.1),
      child: Icon(
        Icons.person,
        size: 42,
        color: colorScheme.primary,
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final bool isExpired;
  final int remainingSeconds;
  final String Function(int) formatter;

  const _StatusRow({
    required this.isExpired,
    required this.remainingSeconds,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
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
              : 'Expires in ${formatter(remainingSeconds)}',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
