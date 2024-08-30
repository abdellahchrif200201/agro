part of 'nutrition_bloc.dart';

sealed class NutritionState extends Equatable {
  const NutritionState();
  
  @override
  List<Object> get props => [];
}

final class NutritionInitial extends NutritionState {}

class LoadingNutritionState extends NutritionState{}

class LoadedNutritionState extends NutritionState{
  final List<Nutrition> nutrition;

  const LoadedNutritionState({
    required this.nutrition
  });

  @override
  List<Object> get props => [nutrition];
}

class ErrorNutritionState extends NutritionState{
  final String message;
  const ErrorNutritionState({
    required this.message
});
  @override
  List<Object> get props => [message];


}

