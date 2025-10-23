import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_test/core/error/exceptions.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_stat_entity.dart';
import 'package:pokemon_test/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/cubit/pokemon_details_cubit.dart';

class _MockPokemonDetailsRepository extends Mock
    implements PokemonDetailsRepository {}

class _MockFavoritesStorage extends Mock implements FavoritesStorage {}

void main() {
  late _MockPokemonDetailsRepository repository;
  late _MockFavoritesStorage favoritesStorage;
  late PokemonDetailsCubit cubit;

  const detail = PokemonDetailEntity(
    name: 'pikachu',
    displayName: 'Pikachu',
    types: ['electric'],
    typesLabel: 'Electric',
    species: 'mouse',
    heightMeters: 0.4,
    weightKilograms: 6.0,
    abilities: ['static'],
    stats: [PokemonStatEntity(name: 'speed', value: 90)],
    imageUrl: 'https://example.com/pikachu.png',
  );

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    repository = _MockPokemonDetailsRepository();
    favoritesStorage = _MockFavoritesStorage();
    cubit = PokemonDetailsCubit(repository, favoritesStorage: favoritesStorage);
  });

  tearDown(() async {
    await cubit.close();
  });

  group('fetchPokemonDetail', () {
    test('emits loading then loaded when repository succeeds', () async {
      when(
        () => repository.getPokemonDetail('pikachu'),
      ).thenAnswer((_) async => detail);
      when(() => favoritesStorage.isFavorite(detail.name)).thenReturn(true);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const PokemonDetailsLoading(),
          isA<PokemonDetailsLoaded>()
              .having((state) => state.detail, 'detail', detail)
              .having((state) => state.isFavorite, 'isFavorite', true),
        ]),
      );

      await cubit.fetchPokemonDetail(' Pikachu ');

      verify(() => repository.getPokemonDetail('pikachu')).called(1);
      verify(() => favoritesStorage.isFavorite(detail.name)).called(1);
    });

    test('emits error when name is empty', () async {
      await cubit.fetchPokemonDetail('   ');

      expect(
        cubit.state,
        isA<PokemonDetailsError>().having(
          (state) => state.message,
          'message',
          'Pokemon name is required',
        ),
      );
      verifyNever(() => repository.getPokemonDetail(any()));
    });

    test('emits error when repository throws', () async {
      when(
        () => repository.getPokemonDetail('pikachu'),
      ).thenThrow(ServerException('network down'));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const PokemonDetailsLoading(),
          isA<PokemonDetailsError>().having(
            (state) => state.message,
            'message',
            contains('network down'),
          ),
        ]),
      );

      await cubit.fetchPokemonDetail('pikachu');
    });
  });

  group('toggleFavorite', () {
    test(
      'adds favorite when current state is loaded and not favorite',
      () async {
        when(
          () => repository.getPokemonDetail('pikachu'),
        ).thenAnswer((_) async => detail);
        when(() => favoritesStorage.isFavorite(detail.name)).thenReturn(false);
        when(
          () => favoritesStorage.saveFavorite(any(), any()),
        ).thenAnswer((_) {});

        await cubit.fetchPokemonDetail('pikachu');
        expect(cubit.state, isA<PokemonDetailsLoaded>());

        cubit.toggleFavorite();

        expect(
          cubit.state,
          isA<PokemonDetailsLoaded>().having(
            (state) => state.isFavorite,
            'isFavorite',
            true,
          ),
        );

        verify(
          () => favoritesStorage.saveFavorite(detail.name, any()),
        ).called(1);
        verifyNever(() => favoritesStorage.removeFavorite(any()));
      },
    );

    test(
      'removes favorite when current state is loaded and favorite',
      () async {
        when(
          () => repository.getPokemonDetail('pikachu'),
        ).thenAnswer((_) async => detail);
        when(() => favoritesStorage.isFavorite(detail.name)).thenReturn(true);
        when(() => favoritesStorage.removeFavorite(any())).thenAnswer((_) {});

        await cubit.fetchPokemonDetail('pikachu');
        expect(cubit.state, isA<PokemonDetailsLoaded>());

        cubit.toggleFavorite();

        expect(
          cubit.state,
          isA<PokemonDetailsLoaded>().having(
            (state) => state.isFavorite,
            'isFavorite',
            false,
          ),
        );

        verify(() => favoritesStorage.removeFavorite(detail.name)).called(1);
        verifyNever(() => favoritesStorage.saveFavorite(any(), any()));
      },
    );

    test('does nothing when state is not loaded', () async {
      cubit.toggleFavorite();

      expect(cubit.state, isA<PokemonDetailsState>());
      verifyNever(() => favoritesStorage.saveFavorite(any(), any()));
      verifyNever(() => favoritesStorage.removeFavorite(any()));
    });

    test('emits error and restores previous state when save fails', () async {
      when(
        () => repository.getPokemonDetail('pikachu'),
      ).thenAnswer((_) async => detail);
      when(() => favoritesStorage.isFavorite(detail.name)).thenReturn(false);
      when(
        () => favoritesStorage.saveFavorite(any(), any()),
      ).thenThrow(CacheException('cache failure'));

      await cubit.fetchPokemonDetail('pikachu');
      expect(
        cubit.state,
        isA<PokemonDetailsLoaded>().having(
          (state) => state.isFavorite,
          'isFavorite',
          false,
        ),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<PokemonDetailsError>().having(
            (state) => state.message,
            'message',
            contains('cache failure'),
          ),
          isA<PokemonDetailsLoaded>().having(
            (state) => state.isFavorite,
            'isFavorite',
            false,
          ),
        ]),
      );

      cubit.toggleFavorite();
    });
  });
}
