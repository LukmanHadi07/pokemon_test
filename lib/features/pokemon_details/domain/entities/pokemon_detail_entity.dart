import 'package:equatable/equatable.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_stat_entity.dart';

class PokemonDetailEntity extends Equatable {
  final String name;
  final String displayName;
  final List<String> types;
  final String typesLabel;
  final String species;
  final double heightMeters;
  final double weightKilograms;
  final List<String> abilities;
  final List<PokemonStatEntity> stats;
  final String imageUrl;

  const PokemonDetailEntity({
    required this.name,
    required this.displayName,
    required this.types,
    required this.typesLabel,
    required this.species,
    required this.heightMeters,
    required this.weightKilograms,
    required this.abilities,
    required this.stats,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        name,
        displayName,
        types,
        typesLabel,
        species,
        heightMeters,
        weightKilograms,
        abilities,
        stats,
        imageUrl,
      ];
}
