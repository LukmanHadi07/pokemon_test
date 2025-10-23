// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_stat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonStatModel _$PokemonStatModelFromJson(Map<String, dynamic> json) =>
    PokemonStatModel(
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$PokemonStatModelToJson(PokemonStatModel instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};
