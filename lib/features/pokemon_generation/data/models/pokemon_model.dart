import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel extends Equatable {
  final String name;
  final String url;
  @JsonKey(name: 'main_region')
  final Map<String, dynamic>? mainRegion;

  const PokemonModel({required this.name, required this.url, this.mainRegion});

  String get imageUrl {
    try {
      final parts = url.split('/').where((e) => e.isNotEmpty).toList();
      final id = int.tryParse(parts.last) ?? 0;

      return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
    } catch (e) {
      return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png';
    }
  }

  String get regionName => mainRegion?['name'] ?? 'Unknown';

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);

  @override
  List<Object?> get props => [name, url, mainRegion];
}
