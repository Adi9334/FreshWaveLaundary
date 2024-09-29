import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Components/Skeleton.dart';

class ServiceCardSkeleton extends StatelessWidget {
  const ServiceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton(height: 200, width: 200);
  }
}
