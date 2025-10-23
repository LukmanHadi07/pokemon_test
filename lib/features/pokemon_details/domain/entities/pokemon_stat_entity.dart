import 'package:equatable/equatable.dart';

class PokemonStatEntity extends Equatable {
  final String name;
  final int value;

  const PokemonStatEntity({
    required this.name,
    required this.value,
  });

  @override
  List<Object?> get props => [name, value];
}
