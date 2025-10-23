import 'package:pokemon_test/core/network/base_remote_data_source.dart';
import 'package:pokemon_test/features/pokemon_details/data/models/pokemon_detail_model.dart';

class PokemonDetailsRemoteDataSource extends BaseRemoteDataSource {
  PokemonDetailsRemoteDataSource(super.client);

  Future<PokemonDetailModel> getPokemonDetail(String name) {
    return getObject(
      path: 'pokemon/$name',
      fromJson: (json) => PokemonDetailModel.fromJson(json),
    );
  }
}
