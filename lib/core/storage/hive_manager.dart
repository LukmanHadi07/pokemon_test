import 'package:hive_ce_flutter/adapters.dart';
import 'package:pokemon_test/core/error/exceptions.dart';

class HiveManager {
  static const favoriteBox = 'favorites';

  static Future<void> init() async {
    // melakukan inisialisasi Hive
    await Hive.initFlutter();

    // membuka box untuk menyimpan data favorit
    await Hive.openBox(favoriteBox);
  }

  // membuat getter untuk mendapatkan instance box favorit
  static Box get box => Hive.box(favoriteBox);

  // mengambil daftar favorit dari Hive
  static List<Map<String, dynamic>> getFavorites() {
    try {
      return box.values
          .whereType<Map>()
          .map((value) => Map<String, dynamic>.from(value))
          .toList();
    } catch (_) {
      throw CacheException('Gagal mengambil data favorit dari cache');
    }
  }

  static Map<String, dynamic>? getFavorite(String pokemonName) {
    try {
      final data = box.get(pokemonName);
      if (data is Map) {
        return Map<String, dynamic>.from(data);
      }
      if (data is String) {
        return {'name': data, 'displayName': data, 'imageUrl': ''};
      }
      return null;
    } catch (_) {
      throw CacheException('Gagal mengambil data favorit dari cache');
    }
  }

  static void saveFavorite(String pokemonName, Map<String, dynamic> data) {
    try {
      box.put(pokemonName, data);
    } catch (e) {
      throw CacheException('Gagal menambahkan data favorit ke cache');
    }
  }

  static void removeFavorite(String pokemonName) {
    try {
      box.delete(pokemonName);
    } catch (_) {
      throw CacheException('Gagal menghapus data favorit dari cache');
    }
  }

  // memeriksa apakah sebuah pokemon ada di favorit
  static bool isFavorite(String pokemonName) {
    try {
      return box.containsKey(pokemonName);
    } catch (_) {
      throw CacheException('Gagal memeriksa data favorit di cache');
    }
  }
}
