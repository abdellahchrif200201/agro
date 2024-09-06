part of 'add_delete_update_tache_bloc.dart';


abstract class AddDeleteUpdateTacheState extends Equatable {
  const AddDeleteUpdateTacheState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateTacheInitial extends AddDeleteUpdateTacheState {}

class LoadingAddDeleteUpdateTacheState extends AddDeleteUpdateTacheState {}

class ErrorAddDeleteUpdateTacheState extends AddDeleteUpdateTacheState {
  final String message;

  const ErrorAddDeleteUpdateTacheState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdateTacheState extends AddDeleteUpdateTacheState {
  final String message;

  const MessageAddDeleteUpdateTacheState({required this.message});

  @override
  List<Object> get props => [message];
}
