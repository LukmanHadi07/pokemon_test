import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/favorite_model.dart';

class FavoritePokemonCard extends StatelessWidget {
  final FavoritePokemon pokemon;

  const FavoritePokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().currentTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              pokemon.primaryStatLabel,
              style: theme.fontLocalTheme.bodyMediumSemiBoldFont.copyWith(
                color: AppColors.tealGreen,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: pokemon.imageUrl.isNotEmpty
                      ? Image.network(
                          pokemon.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.catching_pokemon,
                              color: AppColors.brightAquaGreen,
                              size: 48,
                            );
                          },
                        )
                      : Icon(
                          Icons.catching_pokemon,
                          color: AppColors.brightAquaGreen,
                          size: 48,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              pokemon.displayName,
              textAlign: TextAlign.center,
              style: theme.fontLocalTheme.bodyMediumSemiBoldFont.copyWith(
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
