part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserEvent extends UserEvent {

  @override
  List<Object> get props => [];
}

class RefreshUserEvent extends UserEvent {}
