import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().currentTheme;
    final labelStyle = theme.fontLocalTheme.bodyMediumRegularFont.copyWith(
      color: AppColors.black,
    );

    final valueStyle = theme.fontLocalTheme.bodyMediumRegularFont.copyWith(
      color: AppColors.black,
    );

    return Row(
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        Text(
          ':',
          style: theme.fontLocalTheme.bodyMediumRegularFont.copyWith(
            color: AppColors.black,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(value, style: valueStyle)),
      ],
    );
  }
}
