part of 'delete_update_chambre_bloc.dart';

abstract class DeleteUpdateChambreState extends Equatable {
  const DeleteUpdateChambreState();

  @override
  List<Object> get props => [];
}

class DeleteUpdateChambreInitial extends DeleteUpdateChambreState {}

class LoadingDeleteUpdateChambreState extends DeleteUpdateChambreState {}

class ErrorDeleteUpdateChambreState extends DeleteUpdateChambreState {
  final String message;

  const ErrorDeleteUpdateChambreState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageDeleteUpdateChambreState extends DeleteUpdateChambreState {
  final String message;

  const MessageDeleteUpdateChambreState({required this.message});

  @override
  List<Object> get props => [message];
}
