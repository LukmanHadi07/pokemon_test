import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_stat_entity.dart';

class HpStatRow extends StatelessWidget {
  final PokemonStatEntity? stat;
  const HpStatRow({super.key, required this.stat});

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text('HP', style: labelStyle)),
        const Text(
          ':',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black38,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            stat != null ? '${stat!.value} HP' : '--',
            style: valueStyle,
          ),
        ),
      ],
    );
  }
}
