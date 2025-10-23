// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
