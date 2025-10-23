import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_test/core/error/exceptions.dart';
import 'package:pokemon_test/core/storage/hive_manager.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_test/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';

part 'pokemon_details_state.dart';

abstract class FavoritesStorage {
  bool isFavorite(String pokemonName);
  void saveFavorite(String pokemonName, Map<String, dynamic> data);
  void removeFavorite(String pokemonName);
}

class HiveFavoritesStorage implements FavoritesStorage {
  const HiveFavoritesStorage();

  @override
  bool isFavorite(String pokemonName) {
    return HiveManager.isFavorite(pokemonName);
  }

  @override
  void removeFavorite(String pokemonName) {
    HiveManager.removeFavorite(pokemonName);
  }

  @override
  void saveFavorite(String pokemonName, Map<String, dynamic> data) {
    HiveManager.saveFavorite(pokemonName, data);
  }
}

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  final PokemonDetailsRepository repository;
  final FavoritesStorage favoritesStorage;
  String? _lastRequestedName;

  PokemonDetailsCubit(
    this.repository, {
    FavoritesStorage? favoritesStorage,
  })  : favoritesStorage = favoritesStorage ?? const HiveFavoritesStorage(),
        super(const PokemonDetailsInitial());

  Future<void> fetchPokemonDetail(String name) async {
    final normalizedName = name.trim().toLowerCase();
    if (normalizedName.isEmpty) {
      emit(const PokemonDetailsError('Pokemon name is required'));
      return;
    }
    _lastRequestedName = normalizedName;
    emit(const PokemonDetailsLoading());
    try {
      final detail = await repository.getPokemonDetail(normalizedName);
      final isFavorite = favoritesStorage.isFavorite(detail.name);
      emit(
        PokemonDetailsLoaded(
          detail: detail,
          isFavorite: isFavorite,
        ),
      );
    } on ServerException catch (e) {
      emit(PokemonDetailsError(e.message));
    } on CacheException catch (e) {
      emit(PokemonDetailsError(e.message));
    } catch (_) {
      emit(const PokemonDetailsError(
        'Terjadi kesalahan saat memuat detail. Silakan coba lagi.',
      ));
    }
  }

  Future<void> retry() async {
    final name = _lastRequestedName;
    if (name == null || name.isEmpty) return;
    await fetchPokemonDetail(name);
  }

  void toggleFavorite() {
    final currentState = state;
    if (currentState is! PokemonDetailsLoaded) return;

    final detail = currentState.detail;
    final isCurrentlyFavorite = currentState.isFavorite;

    try {
      if (isCurrentlyFavorite) {
        favoritesStorage.removeFavorite(detail.name);
      } else {
        favoritesStorage.saveFavorite(detail.name, _serializeDetail(detail));
      }

      emit(
        currentState.copyWith(isFavorite: !isCurrentlyFavorite),
      );
    } on CacheException catch (e) {
      emit(PokemonDetailsError(e.message));
      emit(currentState);
    } catch (_) {
      emit(const PokemonDetailsError(
        'Gagal memperbarui status favorit. Silakan coba lagi.',
      ));
      emit(currentState);
    }
  }

  Map<String, dynamic> _serializeDetail(PokemonDetailEntity detail) {
    return {
      'name': detail.name,
      'displayName': detail.displayName,
      'imageUrl': detail.imageUrl,
      'types': detail.types,
      'typesLabel': detail.typesLabel,
      'species': detail.species,
      'heightMeters': detail.heightMeters,
      'weightKilograms': detail.weightKilograms,
      'abilities': detail.abilities,
      'stats': detail.stats
          .map((stat) => {'name': stat.name, 'value': stat.value})
          .toList(),
    };
  }
}
