part of 'etiquetage_bloc.dart';

sealed class EtiquetageState extends Equatable {
  const EtiquetageState();
  
  @override
  List<Object> get props => [];
}

final class EtiquetageInitial extends EtiquetageState {}

// Loading

class LoadingEtiquetageState extends EtiquetageState{}

// Loaded

class LoadedEtiquetageState extends EtiquetageState{
  final List<Etiquetage> etiquetage;

  const LoadedEtiquetageState({
    required this.etiquetage
  });
  @override
  List<Object> get props => [etiquetage];
}

// error


class ErrorEtiquetageState extends EtiquetageState{
  final String message;

  const ErrorEtiquetageState({
    required this.message
  });
  @override
  List<Object> get props => [message];
}
