import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_detail_entity.dart';

abstract class PokemonDetailsRepository {
  Future<PokemonDetailEntity> getPokemonDetail(String name);
}
