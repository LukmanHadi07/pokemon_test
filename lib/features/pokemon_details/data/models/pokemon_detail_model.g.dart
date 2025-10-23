// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetailModel _$PokemonDetailModelFromJson(Map<String, dynamic> json) =>
    PokemonDetailModel(
      name: json['name'] as String,
      heightDecimeter: (json['heightDecimeter'] as num).toInt(),
      weightHectogram: (json['weightHectogram'] as num).toInt(),
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      stats: (json['stats'] as List<dynamic>)
          .map((e) => PokemonStatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['imageUrl'] as String,
      speciesName: json['speciesName'] as String,
    );

Map<String, dynamic> _$PokemonDetailModelToJson(PokemonDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'heightDecimeter': instance.heightDecimeter,
      'weightHectogram': instance.weightHectogram,
      'types': instance.types,
      'abilities': instance.abilities,
      'stats': instance.stats.map((e) => e.toJson()).toList(),
      'imageUrl': instance.imageUrl,
      'speciesName': instance.speciesName,
    };
