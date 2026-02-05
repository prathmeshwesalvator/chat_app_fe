import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContactShimmerTile extends StatelessWidget {
  const ContactShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Colors.grey.shade300;
    final highlight = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            const CircleAvatar(radius: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14, width: 140, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(height: 12, width: 90, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
