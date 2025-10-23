import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FavoritePokemon extends Equatable {
  final String name;
  final String displayName;
  final String imageUrl;
  final String statLabel;

  const FavoritePokemon({
    required this.name,
    required this.displayName,
    required this.imageUrl,
    required this.statLabel,
  });

  factory FavoritePokemon.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'];
    String statLabel = '';

    if (stats is List && stats.isNotEmpty) {
      final first = stats.first;
      if (first is Map && first['base_stat'] != null) {
        statLabel = first['base_stat'].toString();
      } else if (first['value'] != null) {
        statLabel = first['value'].toString();
      }
    }

    return FavoritePokemon(
      name: json['name']?.toString() ?? '',
      displayName:
          json['displayName']?.toString() ??
          json['name']?.toString() ??
          'Unknown',
      imageUrl:
          json['imageUrl']?.toString() ??
          _buildImageUrlFromSpecies(json['url']?.toString()),
      statLabel: statLabel,
    );
  }

  static String _buildImageUrlFromSpecies(String? url) {
    if (url == null || url.isEmpty) return '';
    try {
      final id =
          int.tryParse(url.split('/').where((e) => e.isNotEmpty).last) ?? 0;
      return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
    } catch (_) {
      return '';
    }
  }

  Map<String, dynamic> toJson() => _$FavoritePokemonToJson(this);

  String get primaryStatLabel => statLabel.isEmpty ? '---' : statLabel;

  @override
  List<Object?> get props => [name, displayName, imageUrl, statLabel];
}
