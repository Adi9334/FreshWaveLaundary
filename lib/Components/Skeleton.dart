import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double width;
  const Skeleton({
    Key? key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
