import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_cubit.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

    // Generate QR once when page opens
    context.read<QrBloc>().add(GenerateHash());

    // Countdown timer (ticks every second)
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {}); // forces rebuild for countdown
      }
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
    return BlocBuilder<QrBloc, QrState>(
      builder: (context, state) {
        final userState = context.read<HomeCubit>().state;

        final createdAt =
            DateTime.tryParse(state.qrData?.createdAt ?? '');

        final remainingSeconds = createdAt == null
            ? 0
            : createdAt
                .add(const Duration(minutes: 5))
                .difference(DateTime.now())
                .inSeconds
                .clamp(0, 300);

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),

              Text(
                'Username : ${userState.username}',
                style: const TextStyle(fontSize: 16),
              ),

              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  padding: const EdgeInsets.all(16),
                  data: remainingSeconds > 0
                      ? state.qrData?.contactHash ?? ''
                      : '',
                  eyeStyle:  QrEyeStyle(
                    color:  Theme.of(context).colorScheme.primary,
                    eyeShape: QrEyeShape.square
                  ),
                ),
              ),

              const Text(
                'Scan to add me in your contacts',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),

              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor:
                        remainingSeconds > 0 ? Colors.green : Colors.red,
                  ),
                  Text(
                    remainingSeconds > 0
                        ? 'Expires in ${_formatTime(remainingSeconds)}'
                        : 'QR Expired',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
