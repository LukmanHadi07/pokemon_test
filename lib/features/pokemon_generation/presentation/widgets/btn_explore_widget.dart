import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/image.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';

class BtnExploreWidget extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;

  const BtnExploreWidget({
    super.key,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().currentTheme;
    return SizedBox(
      width: 150,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? AppColors.brightAquaGreen
              : Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: BorderSide(
            color: AppColors.whiteColor,
            width: isActive ? 0 : 1.5,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImageAsset.iconExplore, width: 24, height: 24),
            Gap(8),
            Text(
              'EXPLORE',
              style: theme.fontLocalTheme.bodyMediumSemiBoldFont.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
