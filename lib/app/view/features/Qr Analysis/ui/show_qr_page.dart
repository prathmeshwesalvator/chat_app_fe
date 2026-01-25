import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


@RoutePage()
class ShowQrPage extends StatefulWidget {
  const ShowQrPage({super.key});

  @override
  State<ShowQrPage> createState() => _ShowQrPageState();
}

class _ShowQrPageState extends State<ShowQrPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('this is show qr'));
  }
}
