import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/network/dio_client.dart';
import 'package:pokemon_test/features/pokemon_details/data/datasources/pokemon_details_remote_data_source.dart';
import 'package:pokemon_test/features/pokemon_details/data/repositories/pokemon_details_repository_impl.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/cubit/pokemon_details_cubit.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/views/pokemon_details.dart';

class PokemonDetailsPage extends StatelessWidget {
  final String pokemonName;

  const PokemonDetailsPage({super.key, required this.pokemonName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokemonDetailsCubit(
        PokemonDetailsRepositoryImpl(
          PokemonDetailsRemoteDataSource(DioClient()),
        ),
      )..fetchPokemonDetail(pokemonName),
      child: const PokemonDetailsView(),
    );
  }
}
