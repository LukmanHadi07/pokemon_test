import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';

class TabPill extends StatelessWidget {
  const TabPill({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().currentTheme;
    final backgroundColor = isActive ? AppColors.tealGreen : Colors.transparent;
    final border = isActive
        ? null
        : Border.all(color: AppColors.tealGreen, width: 2);
    final textColor = isActive ? AppColors.whiteColor : AppColors.tealGreen;

    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(28),
          border: border,
        ),
        child: Text(
          label,
          style: theme.fontLocalTheme.bodyLargeSemiBoldFont.copyWith(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
