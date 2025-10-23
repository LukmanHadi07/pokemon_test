import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_stat_model.g.dart';

@JsonSerializable()
class PokemonStatModel extends Equatable {
  final String name;
  final int value;

  const PokemonStatModel({required this.name, required this.value});

  factory PokemonStatModel.fromJson(Map<String, dynamic> json) {
    final statInfo = json['stat'] as Map<String, dynamic>? ?? {};
    return PokemonStatModel(
      name: (statInfo['name'] as String? ?? '').toLowerCase(),
      value: (json['base_stat'] as num? ?? 0).toInt(),
    );
  }

  /// Tambahkan agar json_serializable bisa bekerja
  Map<String, dynamic> toJson() => _$PokemonStatModelToJson(this);

  @override
  List<Object?> get props => [name, value];
}
