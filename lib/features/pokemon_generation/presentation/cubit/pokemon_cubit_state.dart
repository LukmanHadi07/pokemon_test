part of 'pokemon_cubit.dart';

sealed class PokemonCubitState extends Equatable {
  const PokemonCubitState();

  @override
  List<Object> get props => [];
}

final class PokemonCubitInitial extends PokemonCubitState {}

final class PokemonLoading extends PokemonCubitState {}

final class PokemonLoaded extends PokemonCubitState {
  final List<PokemonEntity> pokemons;
  const PokemonLoaded(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}

final class PokemonError extends PokemonCubitState {
  final String message;
  const PokemonError(this.message);

  @override
  List<Object> get props => [message];
}
