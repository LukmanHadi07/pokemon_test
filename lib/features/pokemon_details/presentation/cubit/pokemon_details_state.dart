part of 'pokemon_details_cubit.dart';

abstract class PokemonDetailsState extends Equatable {
  const PokemonDetailsState();

  @override
  List<Object?> get props => [];
}

class PokemonDetailsInitial extends PokemonDetailsState {
  const PokemonDetailsInitial();
}

class PokemonDetailsLoading extends PokemonDetailsState {
  const PokemonDetailsLoading();
}

class PokemonDetailsLoaded extends PokemonDetailsState {
  final PokemonDetailEntity detail;
  final bool isFavorite;

  const PokemonDetailsLoaded({
    required this.detail,
    required this.isFavorite,
  });

  PokemonDetailsLoaded copyWith({
    PokemonDetailEntity? detail,
    bool? isFavorite,
  }) {
    return PokemonDetailsLoaded(
      detail: detail ?? this.detail,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [detail, isFavorite];
}

class PokemonDetailsError extends PokemonDetailsState {
  final String message;

  const PokemonDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
