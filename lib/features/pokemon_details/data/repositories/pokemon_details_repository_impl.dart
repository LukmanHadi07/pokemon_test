import 'package:pokemon_test/features/pokemon_details/data/datasources/pokemon_details_remote_data_source.dart';
import 'package:pokemon_test/features/pokemon_details/data/models/pokemon_detail_model.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_stat_entity.dart';
import 'package:pokemon_test/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';

class PokemonDetailsRepositoryImpl implements PokemonDetailsRepository {
  final PokemonDetailsRemoteDataSource remoteDataSource;

  PokemonDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<PokemonDetailEntity> getPokemonDetail(String name) async {
    final PokemonDetailModel model =
        await remoteDataSource.getPokemonDetail(name);

    final formattedName = _capitalize(model.name);
    final typesLabel = model.types.map(_capitalize).join(' / ');
    final speciesLabel = model.speciesName.isNotEmpty
        ? _capitalize(model.speciesName.replaceAll('-', ' '))
        : formattedName;

    final abilities = model.abilities.map(_capitalize).toList();

    final stats = model.stats
        .map(
          (stat) => PokemonStatEntity(
            name: stat.name,
            value: stat.value,
          ),
        )
        .toList();

    return PokemonDetailEntity(
      name: model.name,
      displayName: formattedName,
      types: model.types,
      typesLabel: typesLabel,
      species: speciesLabel,
      heightMeters: model.heightDecimeter / 10.0,
      weightKilograms: model.weightHectogram / 10.0,
      abilities: abilities,
      stats: stats,
      imageUrl: model.imageUrl,
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : word[0].toUpperCase() + word.substring(1).toLowerCase(),
        )
        .join(' ');
  }
}
