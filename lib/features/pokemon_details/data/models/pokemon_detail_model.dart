import 'package:equatable/equatable.dart';
import 'package:pokemon_test/features/pokemon_details/data/models/pokemon_stat_model.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonDetailModel extends Equatable {
  final String name;
  final int heightDecimeter;
  final int weightHectogram;
  final List<String> types;
  final List<String> abilities;
  final List<PokemonStatModel> stats;
  final String imageUrl;
  final String speciesName;

  const PokemonDetailModel({
    required this.name,
    required this.heightDecimeter,
    required this.weightHectogram,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.imageUrl,
    required this.speciesName,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>? ?? {};
    final other = sprites['other'] as Map<String, dynamic>? ?? {};
    final officialArtwork =
        other['official-artwork'] as Map<String, dynamic>? ?? {};
    final dreamWorld = other['dream_world'] as Map<String, dynamic>? ?? {};
    final home = other['home'] as Map<String, dynamic>? ?? {};

    final typesList = (json['types'] as List<dynamic>? ?? [])
        .map(
          (e) => (e as Map<String, dynamic>)['type']['name'] as String? ?? '',
        )
        .where((name) => name.isNotEmpty)
        .map((name) => name.toLowerCase())
        .toList();

    final abilitiesList = (json['abilities'] as List<dynamic>? ?? [])
        .map(
          (e) =>
              (e as Map<String, dynamic>)['ability']['name'] as String? ?? '',
        )
        .where((name) => name.isNotEmpty)
        .map((name) => name.toLowerCase().replaceAll('-', ' '))
        .toList();

    final statsList = (json['stats'] as List<dynamic>? ?? [])
        .map(
          (e) => PokemonStatModel.fromJson(Map<String, dynamic>.from(e as Map)),
        )
        .toList();

    final species = json['species'] as Map<String, dynamic>? ?? {};

    return PokemonDetailModel(
      name: (json['name'] as String? ?? '').toLowerCase(),
      heightDecimeter: (json['height'] as num? ?? 0).toInt(),
      weightHectogram: (json['weight'] as num? ?? 0).toInt(),
      types: typesList,
      abilities: abilitiesList,
      stats: statsList,
      imageUrl:
          (officialArtwork['front_default'] as String?) ??
          (home['front_default'] as String?) ??
          (dreamWorld['front_default'] as String?) ??
          (sprites['front_default'] as String?) ??
          '',
      speciesName: (species['name'] as String? ?? '').toLowerCase(),
    );
  }

  Map<String, dynamic> toJson() => _$PokemonDetailModelToJson(this);

  @override
  List<Object?> get props => [
    name,
    heightDecimeter,
    weightHectogram,
    types,
    abilities,
    stats,
    imageUrl,
    speciesName,
  ];
}
