import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/start_bar.dart';

class StatBarRow extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const StatBarRow({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().currentTheme;

    final labelStyle = theme.fontLocalTheme.bodyMediumRegularFont.copyWith(
      color: AppColors.black,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        Text(
          ':',
          style: theme.fontLocalTheme.bodyMediumRegularFont.copyWith(
            color: AppColors.black,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: StatBar(value: value, color: color),
        ),
      ],
    );
  }
}
