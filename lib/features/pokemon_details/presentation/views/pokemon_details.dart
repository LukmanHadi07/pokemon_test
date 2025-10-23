import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/image.dart';
import 'package:pokemon_test/core/utils/widgets/error_state_widget.dart';
import 'package:pokemon_test/features/pokemon_details/data/enums/detail_section.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/cubit/pokemon_details_cubit.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/art_work_with_card.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/header_section.dart';

class PokemonDetailsView extends StatefulWidget {
  const PokemonDetailsView({super.key});

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  DetailSection _section = DetailSection.about;

  void _onSectionChanged(DetailSection section) {
    if (_section == section) return;
    setState(() => _section = section);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAsset.backgroundDetailPage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<PokemonDetailsCubit, PokemonDetailsState>(
            listenWhen: (previous, current) =>
                previous is PokemonDetailsLoaded &&
                current is PokemonDetailsError,
            listener: (context, state) {
              if (state is PokemonDetailsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    action: SnackBarAction(
                      label: 'Coba Lagi',
                      onPressed: () =>
                          context.read<PokemonDetailsCubit>().toggleFavorite(),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is PokemonDetailsLoading ||
                  state is PokemonDetailsInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is PokemonDetailsError) {
                return ErrorStateWidget(
                  title: 'Gagal memuat detail pokemon',
                  message: state.message,
                  icon: Icons.wifi_off,
                  onRetry: () =>
                      context.read<PokemonDetailsCubit>().retry(),
                );
              }

              if (state is PokemonDetailsLoaded) {
                final detail = state.detail;
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const HeaderNavigation(),
                      const SizedBox(height: 32),
                      ArtworkWithCard(
                        detail: detail,
                        section: _section,
                        onSectionChanged: _onSectionChanged,
                        isFavorite: state.isFavorite,
                        onFavoriteToggle: () => context
                            .read<PokemonDetailsCubit>()
                            .toggleFavorite(),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
