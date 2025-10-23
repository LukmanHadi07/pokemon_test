import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_test/core/error/exceptions.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/entities/pokemon_entity.dart';

import 'package:pokemon_test/features/pokemon_generation/domain/repositories/generation_repository.dart';

part 'pokemon_cubit_state.dart';

class PokemonCubit extends Cubit<PokemonCubitState> {
  final GenerationRepository generationRepository;
  PokemonCubit(this.generationRepository) : super(PokemonCubitInitial());

  Future<void> fetchPokemonsByGeneration(int id) async {
    emit(PokemonLoading());
    try {
      final result = await generationRepository.getPokemonsByGeneration(id);
      emit(PokemonLoaded(result));
    } catch (e) {
      final message = e is ServerException
          ? e.message
          : 'Gagal mengambil data pokemon. Silakan coba lagi.';
      emit(PokemonError(message));
    }
  }
}
