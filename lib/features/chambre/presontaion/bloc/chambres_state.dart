part of 'chambres_bloc.dart';

abstract class ChambresState extends Equatable {
  const ChambresState();

  @override
  List<Object?> get props => [];
}

class ChambresInitial extends ChambresState {}

class LoadingChambresState extends ChambresState {}

class LoadedChambresState extends ChambresState {
  final List<Chambre> chambres;

  LoadedChambresState({required this.chambres});

  @override
  List<Object?> get props => [chambres];
}

class ErrorChambresState extends ChambresState {
  final String message;

  ErrorChambresState({required this.message});

  @override
  List<Object?> get props => [message];
}
