part of 'delete_add_update_user_bloc.dart';

abstract class AddDeleteUpdateUserEvent extends Equatable {
  const AddDeleteUpdateUserEvent();

  @override
  List<Object> get props => [];
}

class AddUserEvent extends AddDeleteUpdateUserEvent {
  final User user;

  AddUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateUserEvent extends AddDeleteUpdateUserEvent {
  final User user;

  UpdateUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class DeleteUserEvent extends AddDeleteUpdateUserEvent {
  final int userId;

  const DeleteUserEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
