import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';

class ContainerGenerationWidget extends StatelessWidget {
  final String title;
  const ContainerGenerationWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().currentTheme;
    return Container(
      width: 280,
      height: 55,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.brightAquaGreen, width: 2),
        borderRadius: BorderRadius.circular(40),
        color: Colors.transparent,
      ),
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: theme.fontLocalTheme.bodyLargeSemiBoldFont.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.brightAquaGreen,
          ),
        ),
      ),
    );
  }
}
