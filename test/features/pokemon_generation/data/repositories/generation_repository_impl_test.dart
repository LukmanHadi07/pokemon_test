import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_test/features/pokemon_generation/data/datasources/remote/generation_remote_data_source.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/generation_model.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/pokemon_model.dart';
import 'package:pokemon_test/features/pokemon_generation/data/repositories/generation_repository_impl.dart';

class _MockGenerationRemoteDataSource extends Mock
    implements GenerationRemoteDataSource {}

void main() {
  late _MockGenerationRemoteDataSource dataSource;
  late GenerationRepositoryImpl repository;

  setUp(() {
    dataSource = _MockGenerationRemoteDataSource();
    repository = GenerationRepositoryImpl(dataSource);
  });

  group('getGenerations', () {
    test('returns mapped entities from data source', () async {
      const models = [
        GenerationModel(name: 'generation-i', url: 'https://pokeapi.co/generation/1/'),
        GenerationModel(name: 'generation-ii', url: 'https://pokeapi.co/generation/2/'),
      ];

      when(() => dataSource.getGenerations()).thenAnswer((_) async => models);

      final result = await repository.getGenerations();

      expect(result.length, models.length);
      expect(result.first.name, models.first.name);
      expect(result.first.url, models.first.url);
      verify(() => dataSource.getGenerations()).called(1);
    });
  });

  group('getPokemonsByGeneration', () {
    test('returns PokemonEntity objects with image and region data', () async {
      const models = [
        PokemonModel(
          name: 'bulbasaur',
          url: 'https://pokeapi.co/api/v2/pokemon/1/',
          mainRegion: {'name': 'kanto'},
        ),
        PokemonModel(
          name: 'charmander',
          url: 'https://pokeapi.co/api/v2/pokemon/4/',
          mainRegion: {'name': 'kanto'},
        ),
      ];

      when(() => dataSource.getPokemonsByGeneration(1))
          .thenAnswer((_) async => models);

      final result = await repository.getPokemonsByGeneration(1);

      expect(result.length, models.length);
      expect(result.first.name, models.first.name);
      expect(
        result.first.imageUrl,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );
      expect(result.first.regionName, 'kanto');
      verify(() => dataSource.getPokemonsByGeneration(1)).called(1);
    });
  });
}
