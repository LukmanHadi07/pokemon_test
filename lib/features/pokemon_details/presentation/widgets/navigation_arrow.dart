import 'package:flutter/material.dart';
import 'package:pokemon_test/core/theme/color.dart';

class NavigationArrow extends StatelessWidget {
  final IconData icon;
  const NavigationArrow({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.brightAquaGreen,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
