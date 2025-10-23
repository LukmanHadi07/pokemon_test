import 'package:pokemon_test/features/pokemon_generation/data/datasources/remote/generation_remote_data_source.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/generation_model.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/pokemon_model.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/entities/generation_entity.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/entities/pokemon_entity.dart';

import '../../domain/repositories/generation_repository.dart';

class GenerationRepositoryImpl implements GenerationRepository {
  final GenerationRemoteDataSource dataSource;
  GenerationRepositoryImpl(this.dataSource);

  @override
  Future<List<GenerationEntity>> getGenerations() async {
    final List<GenerationModel> models = await dataSource.getGenerations();
    return models
        .map((model) => GenerationEntity(name: model.name, url: model.url))
        .toList();
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByGeneration(int id) async {
    final List<PokemonModel> models = await dataSource.getPokemonsByGeneration(
      id,
    );
    return models
        .map(
          (model) => PokemonEntity(
            name: model.name,
            imageUrl: model.imageUrl,
            regionName: model.regionName,
          ),
        )
        .toList();
  }
}
