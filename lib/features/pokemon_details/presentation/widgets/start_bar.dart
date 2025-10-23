import 'package:flutter/material.dart';
import 'package:pokemon_test/core/theme/color.dart';

class StatBar extends StatelessWidget {
  const StatBar({super.key, required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: LinearProgressIndicator(
        minHeight: 12,
        value: value.clamp(0, 1),
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: AppColors.whiteColor,
      ),
    );
  }
}
