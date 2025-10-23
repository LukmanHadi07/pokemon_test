part of 'generation_cubit_cubit.dart';

sealed class GenerationCubitState extends Equatable {
  const GenerationCubitState();

  @override
  List<Object> get props => [];
}

final class GenerationCubitInitial extends GenerationCubitState {}

final class GenerationLoading extends GenerationCubitState {}

final class GenerationLoaded extends GenerationCubitState {
  final List<GenerationEntity> generations;
  const GenerationLoaded(this.generations);

  @override
  List<Object> get props => [generations];
}

final class GenerationError extends GenerationCubitState {
  final String message;
  const GenerationError(this.message);

  @override
  List<Object> get props => [message];
}
