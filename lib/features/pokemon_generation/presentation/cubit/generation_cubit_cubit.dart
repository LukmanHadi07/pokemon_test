import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_test/core/error/exceptions.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/entities/generation_entity.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/repositories/generation_repository.dart';

part 'generation_cubit_state.dart';

class GenerationCubit extends Cubit<GenerationCubitState> {
  final GenerationRepository generationRepository;
  GenerationCubit(this.generationRepository) : super(GenerationCubitInitial());

  Future<void> fetchGenerations() async {
    emit(GenerationLoading());
    try {
      final result = await generationRepository.getGenerations();
      emit(GenerationLoaded(result));
    } catch (e) {
      final message = e is ServerException
          ? e.message
          : 'Terjadi kesalahan. Silakan coba lagi.';
      emit(GenerationError(message));
    }
  }
}
