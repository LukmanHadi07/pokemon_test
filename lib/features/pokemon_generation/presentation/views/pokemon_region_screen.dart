import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_test/core/network/dio_client.dart';
import 'package:pokemon_test/core/router/route_name.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/image.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';
import 'package:pokemon_test/core/utils/widgets/error_state_widget.dart';
import 'package:pokemon_test/features/pokemon_generation/data/datasources/remote/generation_remote_data_source.dart';
import 'package:pokemon_test/features/pokemon_generation/data/repositories/generation_repository_impl.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/entities/pokemon_entity.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/cubit/pokemon_cubit.dart';

class PokemonRegionScreen extends StatelessWidget {
  final int generationId;
  const PokemonRegionScreen({super.key, required this.generationId});

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().currentTheme;

    return BlocProvider(
      create: (_) => PokemonCubit(
        GenerationRepositoryImpl(GenerationRemoteDataSource(DioClient())),
      )..fetchPokemonsByGeneration(generationId),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAsset.backgroundGenerationImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 8.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Generation $generationId',
                          style: theme.fontLocalTheme.headingSmallSemiBoldFont
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: BlocBuilder<PokemonCubit, PokemonCubitState>(
                    builder: (context, state) {
                      if (state is PokemonLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is PokemonError) {
                        return ErrorStateWidget(
                          title: 'Gagal memuat daftar pokemon',
                          message: state.message,
                          icon: Icons.wifi_off,
                          onRetry: () => context
                              .read<PokemonCubit>()
                              .fetchPokemonsByGeneration(generationId),
                        );
                      }

                      if (state is PokemonLoaded) {
                        final pokemons = state.pokemons;
                        final regionName = pokemons.isNotEmpty
                            ? pokemons.first.regionName
                            : 'Unknown';

                        return Column(
                          children: [
                            Container(
                              width: 250,
                              height: 50,
                              margin: const EdgeInsets.only(
                                top: 20,
                                bottom: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageAsset.iconRegion,
                                    width: 24,
                                    height: 24,
                                  ),
                                  Text(
                                    '  REGION : ',
                                    style: theme
                                        .fontLocalTheme
                                        .bodyMediumRegularFont,
                                  ),
                                  Text(
                                    regionName.toUpperCase(),
                                    style: theme
                                        .fontLocalTheme
                                        .bodyMediumSemiBoldFont,
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                itemCount: pokemons.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 0.85,
                                    ),
                                itemBuilder: (context, index) {
                                  final PokemonEntity p = pokemons[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          // ignore: deprecated_member_use
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 6,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        context.pushNamed(
                                          RouteName.pokemonDetailsScreen,
                                          queryParameters: {'name': p.name},
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            p.imageUrl,
                                            width: 160,
                                            height: 160,
                                            fit: BoxFit.contain,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                ),
                                          ),

                                          const SizedBox(height: 8),
                                          Text(
                                            p.name[0].toUpperCase() +
                                                p.name.substring(1),
                                            style: theme
                                                .fontLocalTheme
                                                .bodyLargeSemiBoldFont,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
