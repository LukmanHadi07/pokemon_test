import 'package:pokemon_test/core/error/exceptions.dart';
import 'package:pokemon_test/core/network/base_remote_data_source.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/generation_model.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/pokemon_model.dart';

class GenerationRemoteDataSource extends BaseRemoteDataSource {
  GenerationRemoteDataSource(super.client);

  Future<List<GenerationModel>> getGenerations() async {
    return getList<GenerationModel>(
      path: 'generation',
      fromJson: GenerationModel.fromJson,
    );
  }

  Future<List<PokemonModel>> getPokemonsByGeneration(int id) async {
    final Map<String, dynamic> data = await getObject<Map<String, dynamic>>(
      path: 'generation/$id',
      fromJson: (json) => json,
    );

    final region = data['main_region'];
    final pokemonSpecies = data['pokemon_species'];

    if (pokemonSpecies is! List) {
      throw ServerException(
        'Invalid API response: pokemon_species is not a list',
      );
    }

    return pokemonSpecies.map((e) {
      final map = Map<String, dynamic>.from(e as Map<String, dynamic>);
      if (region is Map<String, dynamic>) {
        map['main_region'] = region;
      }
      return PokemonModel.fromJson(map);
    }).toList();
  }
}
