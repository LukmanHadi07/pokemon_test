import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_test/core/error/exceptions.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/entities/pokemon_entity.dart';
import 'package:pokemon_test/features/pokemon_generation/domain/repositories/generation_repository.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/cubit/pokemon_cubit.dart';

class _MockGenerationRepository extends Mock implements GenerationRepository {}

void main() {
  final pokemons = [
    const PokemonEntity(
      name: 'bulbasaur',
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      regionName: 'kanto',
    ),
  ];

  late PokemonCubit cubit;
  late _MockGenerationRepository repository;

  setUp(() {
    repository = _MockGenerationRepository();
    cubit = PokemonCubit(repository);
  });

  tearDown(() => cubit.close());

  test('emits loading then loaded when fetch succeeds', () async {
    when(
      () => repository.getPokemonsByGeneration(1),
    ).thenAnswer((_) async => pokemons);

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<PokemonLoading>(),
        isA<PokemonLoaded>().having(
          (state) => state.pokemons,
          'pokemons',
          pokemons,
        ),
      ]),
    );

    await cubit.fetchPokemonsByGeneration(1);
    await expectation;

    verify(() => repository.getPokemonsByGeneration(1)).called(1);
  });

  test('emits loading then error when fetch fails', () async {
    when(
      () => repository.getPokemonsByGeneration(1),
    ).thenThrow(ServerException('network down'));

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<PokemonLoading>(),
        isA<PokemonError>().having(
          (state) => state.message,
          'message',
          contains('network down'),
        ),
      ]),
    );

    await cubit.fetchPokemonsByGeneration(1);
    await expectation;

    verify(() => repository.getPokemonsByGeneration(1)).called(1);
  });
}
