part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
  final List<User> users;

  const LoadedUserState({required this.users});

  @override
  List<Object> get props => [users];
}

class ErrorUserState extends UserState {
  final String message;

  const ErrorUserState({required this.message});

  @override
  List<Object> get props => [message];
}
