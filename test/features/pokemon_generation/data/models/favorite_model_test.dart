import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_test/features/pokemon_generation/data/models/favorite_model.dart';

void main() {
  group('FavoritePokemon.fromJson', () {
    test('reads base_stat from API payload', () {
      final json = {
        'name': 'bulbasaur',
        'displayName': 'Bulbasaur',
        'imageUrl': 'https://example.com/bulbasaur.png',
        'stats': [
          {
            'base_stat': 120,
            'stat': {'name': 'hp'},
          },
        ],
      };

      final model = FavoritePokemon.fromJson(json);

      expect(model.name, 'bulbasaur');
      expect(model.displayName, 'Bulbasaur');
      expect(model.imageUrl, 'https://example.com/bulbasaur.png');
      expect(model.statLabel, '120');
      expect(model.primaryStatLabel, '120');
    });

    test('reads value field from cached payload', () {
      final json = {
        'name': 'pikachu',
        'displayName': 'Pikachu',
        'imageUrl': 'https://example.com/pikachu.png',
        'stats': [
          {'name': 'speed', 'value': 90},
        ],
      };

      final model = FavoritePokemon.fromJson(json);

      expect(model.statLabel, '90');
    });

    test('builds image from species url when missing image', () {
      final json = {
        'name': 'charmander',
        'displayName': 'Charmander',
        'url': 'https://pokeapi.co/api/v2/pokemon/4/',
        'stats': [],
      };

      final model = FavoritePokemon.fromJson(json);

      expect(
        model.imageUrl,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(model.primaryStatLabel, '---');
    });
  });

  group('FavoritePokemon.toJson', () {
    test('serializes fields correctly', () {
      const pokemon = FavoritePokemon(
        name: 'pikachu',
        displayName: 'Pikachu',
        imageUrl: 'https://example.com/pikachu.png',
        statLabel: '90',
      );

      final json = pokemon.toJson();

      expect(json['name'], 'pikachu');
      expect(json['displayName'], 'Pikachu');
      expect(json['imageUrl'], 'https://example.com/pikachu.png');
      expect(json['statLabel'], '90');
    });
  });
}
