import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';

class TitleGenerationWidget extends StatelessWidget {
  final String title;

  const TitleGenerationWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().currentTheme;
    return Text(
      title,
      style: theme.fontLocalTheme.headingSmallSemiBoldFont.copyWith(
        color: AppColors.whiteColor,
      ),
    );
  }
}
