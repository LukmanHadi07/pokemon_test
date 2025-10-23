import 'package:pokemon_test/features/pokemon_generation/domain/entities/generation_entity.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/entities/pokemon_entity.dart';

abstract class GenerationRepository {
  Future<List<GenerationEntity>> getGenerations();
  Future<List<PokemonEntity>> getPokemonsByGeneration(int id);
}
