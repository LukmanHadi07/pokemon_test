import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:pokemon_test/core/error/exceptions.dart';
import 'package:pokemon_test/core/router/route_name.dart';
import 'package:pokemon_test/core/storage/hive_manager.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/core/theme/image.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';
import 'package:pokemon_test/core/utils/widgets/container_generation_w.dart';
import 'package:pokemon_test/core/utils/widgets/error_state_widget.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/favorite_model.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/cubit/generation_cubit_cubit.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/widgets/btn_explore_widget.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/widgets/btn_favorite_widget.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/widgets/favorite_pokemon_card.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/widgets/title_generation_widget.dart';

class GenerationScreen extends StatefulWidget {
  const GenerationScreen({super.key});

  @override
  State<GenerationScreen> createState() => _GenerationScreenState();
}

class _GenerationScreenState extends State<GenerationScreen> {
  bool _showFavorites = false;

  void _onExplorePressed() {
    if (_showFavorites) {
      setState(() {
        _showFavorites = false;
      });
    }
  }

  void _onFavoritePressed() {
    if (!_showFavorites) {
      setState(() {
        _showFavorites = true;
      });
    }
  }

  _FavoritesResult _readFavorites(Box _) {
    try {
      final items = HiveManager.getFavorites()
          .map(FavoritePokemon.fromJson)
          .toList(growable: false);
      return _FavoritesResult(items: items);
    } on CacheException catch (e) {
      return _FavoritesResult(error: e.message);
    } catch (_) {
      return const _FavoritesResult(
        error: 'Terjadi kesalahan saat memuat daftar favorit.',
      );
    }
  }

  Widget _buildTitle() {
    if (!_showFavorites) {
      return const TitleGenerationWidget(title: 'EXPLORE POKEMON');
    }
    return ValueListenableBuilder<Box>(
      valueListenable: HiveManager.box.listenable(),
      builder: (context, box, _) {
        final favorites = _readFavorites(box);
        final count = favorites.items.length;
        final label =
            favorites.error == null && count > 0 ? 'FAVORITE ($count)' : 'FAVORITE';
        return TitleGenerationWidget(title: label);
      },
    );
  }

  Widget _buildFavoriteGrid(ThemeCubit themeCubit) {
    return ValueListenableBuilder<Box>(
      valueListenable: HiveManager.box.listenable(),
      builder: (context, box, _) {
        final favorites = _readFavorites(box);
        if (favorites.error != null) {
          return Center(
            child: ErrorStateWidget(
              title: 'Gagal memuat favorit',
              message: favorites.error,
              icon: Icons.warning_amber_rounded,
              onRetry: () => setState(() {}),
            ),
          );
        }
        if (favorites.items.isEmpty) {
          final theme = themeCubit.currentTheme;
          return Center(
            child: Text(
              'No favorites yet',
              style: theme.fontLocalTheme.bodyLargeSemiBoldFont.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.whiteColor, AppColors.mintCreamGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16),
          ),

          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: favorites.items.length,
            itemBuilder: (context, index) {
              final favorite = favorites.items[index];
              return FavoritePokemonCard(pokemon: favorite);
            },
          ),
        );
      },
    );
  }

  Widget _buildContent(ThemeCubit themeCubit) {
    if (_showFavorites) {
      return _buildFavoriteGrid(themeCubit);
    }
    return BlocBuilder<GenerationCubit, GenerationCubitState>(
      builder: (context, state) {
        if (state is GenerationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GenerationError) {
          return ErrorStateWidget(
            title: 'Gagal memuat daftar generasi',
            message: state.message,
            icon: Icons.wifi_off,
            onRetry: () => context.read<GenerationCubit>().fetchGenerations(),
          );
        } else if (state is GenerationLoaded) {
          final generations = state.generations;
          return SizedBox(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: generations.length,
              itemBuilder: (context, index) {
                final gen = generations[index];
                final generationId = index + 1;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          RouteName.pokemonRegionScreen,
                          queryParameters: {
                            'generationId': generationId.toString(),
                          },
                        );
                      },
                      child: ContainerGenerationWidget(title: gen.name),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAsset.backgroundGenerationImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              _buildTitle(),
              const SizedBox(height: 20),
              Expanded(child: _buildContent(themeCubit)),
              const SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnExploreWidget(
                      isActive: !_showFavorites,
                      onPressed: _onExplorePressed,
                    ),
                    BtnFavoriteWidget(
                      isActive: _showFavorites,
                      onPressed: _onFavoritePressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoritesResult {
  final List<FavoritePokemon> items;
  final String? error;

  const _FavoritesResult({this.items = const [], this.error});
}
