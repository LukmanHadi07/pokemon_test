import 'package:flutter/material.dart';
import 'package:pokemon_test/core/theme/color.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // ignore: deprecated_member_use
      color: AppColors.whiteColor.withOpacity(0.85),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 18, color: AppColors.brightAquaGreen),
        ),
      ),
    );
  }
}
