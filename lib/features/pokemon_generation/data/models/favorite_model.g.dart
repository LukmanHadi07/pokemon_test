// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritePokemon _$FavoritePokemonFromJson(Map<String, dynamic> json) =>
    FavoritePokemon(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      imageUrl: json['imageUrl'] as String,
      statLabel: json['statLabel'] as String,
    );

Map<String, dynamic> _$FavoritePokemonToJson(FavoritePokemon instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayName': instance.displayName,
      'imageUrl': instance.imageUrl,
      'statLabel': instance.statLabel,
    };
