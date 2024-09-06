// delete_add_update_user_state.dart

part of 'delete_add_update_user_bloc.dart';

abstract class AddDeleteUpdateUserState extends Equatable {
  const AddDeleteUpdateUserState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateUserInitial extends AddDeleteUpdateUserState {}

class LoadingAddDeleteUpdateUserState extends AddDeleteUpdateUserState {}

class ErrorAddDeleteUpdateUserState extends AddDeleteUpdateUserState {
  final String message;

  const ErrorAddDeleteUpdateUserState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdateUserState extends AddDeleteUpdateUserState {
  final String message;

   MessageAddDeleteUpdateUserState({required this.message});

  @override
  List<Object> get props => [message];
}
