part of 'Fournisseur_bloc.dart';

sealed class FournisseurState extends Equatable {
  const FournisseurState();
  
  @override
  List<Object> get props => [];
}

final class FournisseurInitial extends FournisseurState {}

class LoadingFournisseurState extends FournisseurState {}

class LoadedFournisseurState extends FournisseurState {
  final List<Fournisseur> fournisseurs;

  const LoadedFournisseurState({required this.fournisseurs});

  @override
  List<Object> get props => [fournisseurs];
}

class ErrorFournisseurState extends FournisseurState {
  final String message;

  const ErrorFournisseurState({required this.message});

  @override
  List<Object> get props => [message];
}
